import 'package:cryptocurrency_flutter/component/most_searched_coins.dart';
import 'package:cryptocurrency_flutter/main.dart';
import 'package:cryptocurrency_flutter/model/search_model.dart';
import 'package:cryptocurrency_flutter/network/local_db/sqflite_methods.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:cryptocurrency_flutter/widgets/cached_network_image.dart';
import 'package:cryptocurrency_flutter/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchString = "";

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    if (mAdShowCount < 5) {
      mAdShowCount++;
    } else {
      mAdShowCount = 0;
      buildInterstitialAd();
    }
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
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text('lbl_coin_market'.translate, style: boldTextStyle(size: 22)),
          ),
          body: Stack(
            children: [
              AppTextField(
                textFieldType: TextFieldType.OTHER,
                decoration: AppCommon.inputDecoration('lbl_search'.translate).copyWith(
                  suffixIcon: Icon(Icons.search, color: Colors.white),
                ),
                onChanged: (s) {
                  searchString = s;
                  setState(() {});
                },
              ).paddingSymmetric(horizontal: 16),
              SnapHelperWidget<List<Coin>>(
                loadingWidget: LoaderWidget(),
                future: SqliteMethods().getSearchedCoins(searchString: searchString),
                onSuccess: (snap) {
                  if (snap.length <= 0) {
                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MostSearchedCoins(),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snap.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            cachedImage(snap[index].thumb.validate(), usePlaceholderIfUrlEmpty: true, width: 30, height: 30),
                            16.width,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${snap[index].name.validate()}', style: boldTextStyle()),
                                Text('${snap[index].symbol.validate()}', style: secondaryTextStyle()),
                              ],
                            ).expand(),
                            Text('#${snap[index].market_cap_rank.validate()}', style: boldTextStyle()),
                          ],
                        ),
                      ).onTap(
                        () {
                          hideKeyboard(context);
                          getSelectedDetailScreen(
                            name: snap[index].name.validate(),
                            id: snap[index].id.validate(),
                            image: snap[index].large.validate(),
                          ).launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                        },
                      );
                    },
                  );
                },
              ).paddingTop(60),
            ],
          ),
        );
      },
    );
  }
}
