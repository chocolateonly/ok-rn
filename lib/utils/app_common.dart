import 'package:cryptocurrency_flutter/main.dart';
import 'package:cryptocurrency_flutter/model/coin_detail_model.dart';
import 'package:cryptocurrency_flutter/screens/coin_detail_screen.dart';
import 'package:cryptocurrency_flutter/screens/coin_detail_screen2.dart';
import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

extension SExt on String {
  String get translate => appLocalizations!.translate(this);
}

class AppCommon {
  /// Common InputDecoration
  static InputDecoration inputDecoration(String? title) {
    return InputDecoration(
      hintText: title.validate(),
      hintStyle: secondaryTextStyle(),
      filled: true,
      fillColor: cardColor,
      border: OutlineInputBorder(borderRadius: radius(20), borderSide: BorderSide(color: secondaryColor)),
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
    );
  }

  static Future<void> launchUrl(String url, {bool forceWebView = false}) async {
    await launch(url, forceWebView: forceWebView, enableJavaScript: true, statusBarBrightness: Brightness.light, webOnlyWindowName: "News").catchError((e) {
      toast('Invalid URL: $url');
    });
  }

  static String parseHtmlString(String? htmlString) {
    return parse(parse(htmlString).body!.text).documentElement!.text;
  }
}

//region Extensions
extension numberFormat on num {
  String get amountPrefix {
    if (this > 999 && this < 99999) {
      return "${(this / 1000).toStringAsFixed(2)} K";
    } else if (this > 99999 && this < 999999) {
      return "${(this / 1000).toStringAsFixed(2)} K";
    } else if (this > 999999 && this < 999999999) {
      return "${(this / 1000000).toStringAsFixed(2)} M";
    } else if (this > 999999999) {
      return "${(this / 1000000000).toStringAsFixed(2)} B";
    } else {
      return this.toString();
    }
  }

  Color get getAmountForColor {
    if (this.isNegative) {
      return dangerColor;
    } else {
      return successColor;
    }
  }
}

extension stringExt on String {
  String get getFormattedDate {
    return DateFormat('dd-MMM-yyy').format(DateTime.parse(this));
  }

  Image assetImage({double width = 24, double height = 24, BoxFit fit = BoxFit.cover}) {
    return Image.asset(this, width: width, height: height, fit: fit);
  }

  Color get getExchangeColor {
    if (this == "green") {
      return Colors.green;
    } else if (this == "red") {
      return Colors.red;
    } else if (this == "yellow") {
      return Colors.yellow;
    } else if (this == "gray") {
      return Colors.grey;
    } else {
      return Colors.transparent;
    }
  }

  String get getExchangeStatus {
    if (this == "green") {
      return 'Trust score is Good. we estimate that this exchange pair has a good liquidity.';
    } else if (this == "red") {
      return 'Trust score is Low. we estimate that this exchange pair has a low liquidity.';
    } else if (this == "yellow") {
      return 'Trust score is Fair. we estimate that this exchange pair has a fair liquidity.';
    } else if (this == "gray") {
      return 'Recently added, score may fluctuate as mor data is collected.';
    } else {
      return 'Trust score is unknown. we do not have sufficient order book data for this exchange pair.';
    }
  }
}
//endregion

Color getExchangeColor(int value) {
  Color selectedColor = Colors.grey;
  if (value > 5) {
    selectedColor = Colors.green;
  } else if (value <= 5 && value > 3) {
    selectedColor = Colors.amber;
  } else if (value <= 3 && value >= 1) {
    selectedColor = Colors.yellow;
  } else {
    selectedColor = Colors.grey;
  }

  return selectedColor;
}

void showMoreDetail(BuildContext context, Ticker data) {
  showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Container();
      },
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierLabel: '',
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.scale(
          scale: anim1.value,
          child: AlertDialog(
            contentPadding: EdgeInsets.symmetric(vertical: 16),
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
            title: Text('${data.market!.name.validate()}', style: boldTextStyle(size: 20)),
            content: Container(
              width: context.width(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppButton(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextIcon(
                      prefix: Icon(
                        Icons.credit_card,
                        size: 16,
                        color: Colors.white,
                      ),
                      expandedText: true,
                      text: '${data.base.validate()}/${data.target.validate()}',
                    ),
                    onTap: () {
                      if (data.trade_url.isEmptyOrNull) {
                        toast("You cannot trade");
                        return;
                      }
                      AppCommon.launchUrl(data.trade_url.validate());
                    },
                  ).paddingSymmetric(horizontal: 24),
                  16.height,
                  SettingItemWidget(
                    title: 'Base Price',
                    titleTextStyle: primaryTextStyle(),
                    trailing: Text('${data.converted_last!.usd.validate()}', style: secondaryTextStyle()),
                  ),
                  Divider(height: 0),
                  SettingItemWidget(
                    title: 'Target Price',
                    titleTextStyle: primaryTextStyle(),
                    trailing: Text('${data.last!.validate()}', style: secondaryTextStyle()),
                  ),
                  Divider(height: 0),
                  SettingItemWidget(
                    title: 'Base Volume',
                    titleTextStyle: primaryTextStyle(),
                    trailing: Text('${data.converted_volume!.usd.validate()}', style: secondaryTextStyle()),
                  ),
                  Divider(height: 0),
                  SettingItemWidget(
                    title: 'Target Volume',
                    titleTextStyle: primaryTextStyle(),
                    trailing: Text('${data.volume.validate()}', style: secondaryTextStyle()),
                  ),
                  Divider(height: 0),
                  SettingItemWidget(
                    title: '24H Volume',
                    titleTextStyle: primaryTextStyle(),
                    trailing: Text('${data.bid_ask_spread_percentage.validate()}', style: secondaryTextStyle()),
                  ),
                  Divider(height: 16),
                  Row(
                    children: [
                      Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: data.trust_score?.getExchangeColor),
                      ),
                      16.width,
                      Text(data.trust_score.validate().getExchangeStatus, style: primaryTextStyle()).expand(),
                    ],
                  ).paddingLeft(8),
                  16.height,
                ],
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300));
}

DashboardType get getSelectedDashboard {
  if (getIntAsync(SharedPreferenceKeys.DASHBOARD_SELECTED_INDEX) == 0) {
    return DashboardType.DASHBOARD_1;
  } else {
    return DashboardType.DASHBOARD_2;
  }
}

Widget getSelectedDetailScreen({String? name, String? id, String? image}) {
  if (getIntAsync(SharedPreferenceKeys.DASHBOARD_SELECTED_INDEX) == 0) {
    return CoinDetailScreen(
      name: name.validate(),
      id: id.validate(),
    );
  } else {
    return CoinDetailScreen2(
      name: name.validate(),
      id: id.validate(),
      image: image.validate(),
    );
  }
}
