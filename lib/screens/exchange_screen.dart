import 'package:cryptocurrency_flutter/model/coin_detail_model.dart';
import 'package:cryptocurrency_flutter/model/coin_sorting_model.dart';
import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:cryptocurrency_flutter/utils/app_functions.dart';
import 'package:cryptocurrency_flutter/utils/get_detail_view_currency.dart';
import 'package:cryptocurrency_flutter/widgets/linear_progress_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class ExchangeScreen extends StatefulWidget {
  List<Ticker> ticker;

  ExchangeScreen({required this.ticker});

  @override
  _ExchangeScreenState createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  BannerAd? myBanner;
  int selectedValue = 0;
  SortingTypeModel selectedTypeValue = SortingTypeModel(id: 0, name: "BTC", value: "btc");

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    myBanner = buildBannerAd()..load();
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
          title: Text('lbl_exchanges'.translate, style: boldTextStyle()),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 60),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Row(
                        children: List.generate(SortingTypeModel.getExchangesSortValue.length, (index) {
                          SortingTypeModel data = SortingTypeModel.getExchangesSortValue[index];
                          return Row(
                            children: [
                              Radio<int>(
                                onChanged: (value) {
                                  selectedValue = value.validate();
                                  selectedTypeValue = data;
                                  setState(() {});
                                },
                                groupValue: selectedValue,
                                value: data.id.validate(),
                              ),
                              Text('${data.name.validate()}', style: primaryTextStyle()),
                            ],
                          );
                        }),
                      ),
                      16.width,
                    ],
                  ),
                  16.height,
                  Table(
                    children: [
                      TableRow(decoration: BoxDecoration(color: secondaryColor.withOpacity(0.2)), children: [
                        Container(padding: EdgeInsets.all(10), child: Text("lbl_exch".translate, textAlign: TextAlign.right, style: boldTextStyle()).center()),
                        Container(padding: EdgeInsets.all(10), child: Text("lbl_pair".translate, textAlign: TextAlign.right, style: boldTextStyle()).center()),
                        Container(padding: EdgeInsets.all(10), child: Text('lbl_price'.translate.capitalizeFirstLetter(), textAlign: TextAlign.right, style: primaryTextStyle())),
                        Container(padding: EdgeInsets.all(10), child: Text('lbl_24H_volume'.translate, textAlign: TextAlign.right, style: primaryTextStyle())),
                      ]),
                    ],
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.ticker.length,
                    itemBuilder: (context, index) {
                      Ticker data = widget.ticker[index];
                      return Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${data.market!.name.validate()}', style: primaryTextStyle(size: 14)),
                                4.height,
                                LinearProgressWidget(value: 10, selectedColor: data.trust_score?.getExchangeColor).center(),
                              ],
                            ).expand(),
                            Text('${data.base.validate()}\n${data.target.validate()}', style: primaryTextStyle(size: 14), textAlign: TextAlign.center).expand(),
                            Text('${getCurrencyPrefix(selectedValue)}${getExchangeFrom(selectedTypeValue, data.converted_last!).validate().amountPrefix}}', style: primaryTextStyle(size: 14), textAlign: TextAlign.right).expand(),
                            Text('${getCurrencyPrefix(selectedValue)}${getExchangeFrom(selectedTypeValue, data.converted_volume!).validate().amountPrefix}}', style: primaryTextStyle(size: 14), textAlign: TextAlign.right).expand(),
                          ],
                        ),
                      ).onTap(() {
                        showMoreDetail(context, data);
                      });
                    },
                  ),
                ],
              ),
            ),
            if (myBanner != null)
              Positioned(
                child: AdWidget(ad: myBanner!),
                bottom: 0,
                left: 0,
                right: 0,
                height: AdSize.banner.height.toDouble(),
              ),
          ],
        ),
      ),
    );
  }
}
