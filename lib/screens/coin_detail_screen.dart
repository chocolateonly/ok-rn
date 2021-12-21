import 'package:cryptocurrency_flutter/component/Market_type_based_on_date_component.dart';
import 'package:cryptocurrency_flutter/component/coin_detail_component.dart';
import 'package:cryptocurrency_flutter/component/detail_component.dart';
import 'package:cryptocurrency_flutter/component/key_metrics_component.dart';
import 'package:cryptocurrency_flutter/component/market_chart_component.dart';
import 'package:cryptocurrency_flutter/model/coin_detail_model.dart';
import 'package:cryptocurrency_flutter/network/rest_api.dart';
import 'package:cryptocurrency_flutter/screens/exchange_screen.dart';
import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:cryptocurrency_flutter/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class CoinDetailScreen extends StatefulWidget {
  String id;
  String name;

  CoinDetailScreen({required this.id, required this.name});

  @override
  _CoinDetailScreenState createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> with TickerProviderStateMixin {
  CoinDetailModel? coinData;
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  InterstitialAd? buildInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Admob.mAdMobInterstitialId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdFailedToLoad: (LoadAdError error) {
          throw error.message;
        }, onAdLoaded: (InterstitialAd ad) {
          ad.show();
        }));
  }

  @override
  void dispose() {
    buildInterstitialAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.name.validate()}', style: boldTextStyle(size: 22)),
          actions: [
            IconButton(
              onPressed: () {
                ExchangeScreen(ticker: coinData!.tickers!).launch(context, pageRouteAnimation: PageRouteAnimation.Scale);
              },
              icon: Icon(Icons.import_export_outlined, size: 24),
            ),
            IconButton(
              onPressed: () {
                DetailComponent(data: coinData!).launch(context, pageRouteAnimation: PageRouteAnimation.Scale);
              },
              icon: Icon(Icons.info_outline, size: 24),
            ),
          ],
        ),
        body: SnapHelperWidget<CoinDetailModel>(
          future: getCoinDetail(name: widget.id),
          loadingWidget: LoaderWidget(),
          onSuccess: (data) {
            if (coinData == null) {
              coinData = data;
            }
            return Container(
              child: RefreshIndicator(
                color: secondaryColor,
                backgroundColor: cardColor,
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                onRefresh: () async {
                  setState(() {});
                  await 2.seconds.delay;
                },
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      16.height,
                      CoinDetailComponent(data: data).paddingSymmetric(horizontal: 16),
                      16.height,
                      MarketTypeBasedOnDateComponent(),
                      MarketChartComponent(coinId: data.id!),
                      KeyMetricsComponent(marketData: data.market_data!),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
