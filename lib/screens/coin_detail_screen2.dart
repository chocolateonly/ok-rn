import 'package:cryptocurrency_flutter/component/coin_description_component.dart';
import 'package:cryptocurrency_flutter/component/coin_detail_component.dart';
import 'package:cryptocurrency_flutter/component/key_metrics_component.dart';
import 'package:cryptocurrency_flutter/component/market_chart_component.dart';
import 'package:cryptocurrency_flutter/model/coin_detail_model.dart';
import 'package:cryptocurrency_flutter/network/rest_api.dart';
import 'package:cryptocurrency_flutter/screens/exchange_screen.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:cryptocurrency_flutter/widgets/cached_network_image.dart';
import 'package:cryptocurrency_flutter/widgets/loader_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';

class CoinDetailScreen2 extends StatefulWidget {
  final String id;
  final String name;
  final String image;

  CoinDetailScreen2({required this.id, required this.name, required this.image});

  @override
  _CoinDetailScreen2State createState() => _CoinDetailScreen2State();
}

class _CoinDetailScreen2State extends State<CoinDetailScreen2> {
  CoinDetailModel? coinData;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

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
    if (kReleaseMode) {
      buildInterstitialAd();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: cachedImage(widget.image, width: 35, height: 35),
          actions: [
            IconButton(
              onPressed: () {
                ExchangeScreen(ticker: coinData!.tickers!).launch(context, pageRouteAnimation: PageRouteAnimation.Scale);
              },
              icon: Icon(Icons.import_export_outlined, size: 24),
            ),
          ],
        ),
        body: SnapHelperWidget<CoinDetailModel>(
          future: getCoinDetail(name: widget.id),
          loadingWidget: LoaderWidget(),
          onSuccess: (snap) {
            if (coinData == null) {
              coinData = snap;
            }
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CoinDetailComponent(data: snap, dashboardType: getSelectedDashboard).paddingSymmetric(horizontal: 16),
                    16.height,
                    MarketChartComponent(coinId: snap.id!, dashboardType: getSelectedDashboard),
                    16.height,
                    KeyMetricsComponent(marketData: snap.market_data!, dashboardType: getSelectedDashboard),
                    16.height,
                    CoinDescriptionWidget(snap: snap)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
