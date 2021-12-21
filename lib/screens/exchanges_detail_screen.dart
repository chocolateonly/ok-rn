import 'package:cryptocurrency_flutter/component/exchange_charts_component.dart';
import 'package:cryptocurrency_flutter/component/exchanges_market_component.dart';
import 'package:cryptocurrency_flutter/model/exchange_detail_model.dart';
import 'package:cryptocurrency_flutter/model/exchnages_response.dart';
import 'package:cryptocurrency_flutter/network/rest_api.dart';
import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:cryptocurrency_flutter/widgets/loader_widget.dart';
import 'package:cryptocurrency_flutter/widgets/metrics_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class ExchangesDetailScreen extends StatefulWidget {
  ExchangesResponse data;

  ExchangesDetailScreen({required this.data});

  @override
  _ExchangesDetailScreenState createState() => _ExchangesDetailScreenState();
}

class _ExchangesDetailScreenState extends State<ExchangesDetailScreen> {
  init() async {
    //
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.data.name}', style: boldTextStyle(size: 24)),
        ),
        body: SnapHelperWidget<ExchangeDetailResponse>(
          loadingWidget: LoaderWidget(),
          future: getExchangesDetail(widget.data.id.validate()),
          onSuccess: (snap) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.height,
                  ExchangeChartComponent(data: widget.data),
                  16.height,
                  SettingSection(
                    title: Text('lbl_about .translate${widget.data.name.validate()}', style: boldTextStyle()),
                    headingDecoration: BoxDecoration(color: cardColor),
                    divider: Offstage(),
                    items: [
                      MetricsWidget(
                        value: '${snap.year_established.validate()}',
                        name: "lbl_year_established".translate,
                        isCurrencyAllowed: false,
                        isBorder: false,
                      ),
                      MetricsWidget(
                        value: '${snap.trust_score_rank.validate()}',
                        name: "lbl_trust_score_rank".translate,
                        isCurrencyAllowed: false,
                        isBorder: false,
                      ),
                      MetricsWidget(
                        value: '${snap.trust_score.validate()}',
                        name: "lbl_trust_score".translate,
                        isCurrencyAllowed: false,
                        isBorder: false,
                      ),
                      MetricsWidget(
                        value: '${snap.country.validate()}',
                        name: "lbl_country".translate,
                        isCurrencyAllowed: false,
                        isBorder: false,
                      ),
                      MetricsWidget(
                        value: '${snap.trade_volume_24h_btc.validate().amountPrefix}',
                        name: "lbl_24h__btc_volume".translate,
                        isCurrencyAllowed: false,
                        isBorder: false,
                      ),
                    ],
                  ),
                  SettingSection(
                    title: Text('lbl_follow_them_on'.translate, style: boldTextStyle()),
                    headingDecoration: BoxDecoration(color: cardColor),
                    divider: Offstage(),
                    items: [
                      16.height,
                      TextIcon(
                        edgeInsets: EdgeInsets.all(16),
                        spacing: 16,
                        prefix: Icon(Icons.link, size: 24),
                        text: "lbl_home_page".translate,
                        expandedText: true,
                        suffix: Icon(Icons.arrow_forward_ios_sharp, size: 16),
                        onTap: () {
                          AppCommon.launchUrl(snap.url.validate(), forceWebView: true);
                        },
                      ),
                      TextIcon(
                        edgeInsets: EdgeInsets.all(16),
                        spacing: 16,
                        prefix: AppImages.facebookImg.assetImage(),
                        text: "lbl_faceBook".translate,
                        expandedText: true,
                        suffix: Icon(Icons.arrow_forward_ios_sharp, size: 16),
                        onTap: () {
                          AppCommon.launchUrl(snap.facebook_url.validate(), forceWebView: true);
                        },
                      ),
                      TextIcon(
                        edgeInsets: EdgeInsets.all(16),
                        spacing: 16,
                        prefix: AppImages.telegramImg.assetImage(),
                        text: "lbl_telegram".translate,
                        expandedText: true,
                        suffix: Icon(Icons.arrow_forward_ios_sharp, size: 16),
                        onTap: () {
                          AppCommon.launchUrl(snap.telegram_url.validate(), forceWebView: true);
                        },
                      ),
                      TextIcon(
                        edgeInsets: EdgeInsets.all(16),
                        spacing: 16,
                        prefix: AppImages.slackImg.assetImage(),
                        text: "lbl_slack".translate,
                        expandedText: true,
                        suffix: Icon(Icons.arrow_forward_ios_sharp, size: 16),
                        onTap: () {
                          AppCommon.launchUrl(snap.slack_url.validate(), forceWebView: true);
                        },
                      ),
                      TextIcon(
                        edgeInsets: EdgeInsets.all(16),
                        spacing: 16,
                        prefix: AppImages.twitterImg.assetImage(),
                        text: "lbl_twitter".translate,
                        expandedText: true,
                        suffix: Icon(Icons.arrow_forward_ios_sharp, size: 16),
                        onTap: () {
                          AppCommon.launchUrl("${SocialMediaBaseUrl.twitterBaseUrl}${snap.twitter_handle.validate()}", forceWebView: true);
                        },
                      ),
                      TextIcon(
                        edgeInsets: EdgeInsets.all(16),
                        spacing: 16,
                        prefix: AppImages.redditImg.assetImage(),
                        text: "lbl_reddit".translate,
                        expandedText: true,
                        suffix: Icon(Icons.arrow_forward_ios_sharp, size: 16),
                        onTap: () {
                          AppCommon.launchUrl(snap.reddit_url.validate(), forceWebView: true);
                        },
                      ),
                      TextIcon(
                        edgeInsets: EdgeInsets.all(16),
                        spacing: 16,
                        prefix: Icon(Icons.link, size: 24),
                        text: "lbl_other_url_1".translate,
                        expandedText: true,
                        suffix: Icon(Icons.arrow_forward_ios_sharp, size: 16),
                        onTap: () {
                          AppCommon.launchUrl(snap.other_url_1.validate(), forceWebView: true);
                        },
                      ),
                      TextIcon(
                        edgeInsets: EdgeInsets.all(16),
                        spacing: 16,
                        prefix: Icon(Icons.link, size: 24),
                        text: "lbl_other_url_2".translate,
                        expandedText: true,
                        suffix: Icon(Icons.arrow_forward_ios_sharp, size: 16),
                        onTap: () {
                          AppCommon.launchUrl(snap.other_url_2.validate(), forceWebView: true);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: secondaryColor,
          onPressed: () {
            ExchangesMarketComponent(name: 'binance', id: widget.data.id.validate()).launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
          },
          label: Text('lbl_market'.translate, style: boldTextStyle()),
        ),
      ),
    );
  }
}
