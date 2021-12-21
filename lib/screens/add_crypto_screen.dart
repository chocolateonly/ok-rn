import 'package:cryptocurrency_flutter/main.dart';
import 'package:cryptocurrency_flutter/model/search_model.dart';
import 'package:cryptocurrency_flutter/network/local_db/sqflite_methods.dart';
import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:cryptocurrency_flutter/widgets/crypto_follow_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';

class AddCryptoScreen extends StatefulWidget {
  @override
  _AddCryptoScreenState createState() => _AddCryptoScreenState();
}

class _AddCryptoScreenState extends State<AddCryptoScreen> {
  ScrollController scrollController = ScrollController();
  int page = 1;
  List<Coin> mainList = [];
  bool isLastPage = false;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    fetchCategoryData();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (!isLastPage) {
          page++;
          loadMoreData();
        }
      }
    });
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

  Future fetchCategoryData() async {
    appStore.setLoading(true);

    SqliteMethods.getCoins(page: page, perPage: 50, searchString: controller.text.trim()).then((value) {
      if (controller.text.trim().isNotEmpty) {
        mainList.clear();
        page = 1;
        isLastPage = false;
      }

      mainList.addAll(value);
      setState(() {});
    }).catchError((e) {
      toast(e.toString());
    }).whenComplete(() {
      appStore.setLoading(false);
    });
  }

  Future loadMoreData() async {
    appStore.setLoading(true);
    await SqliteMethods.getCoins(page: page, perPage: 50).then((res) {
      if (!mounted) return;
      appStore.setLoading(false);
      mainList.addAll(res);

      isLastPage = false;
      setState(() {});
    }).catchError((error) {
      if (!mounted) return;
      setState(() {
        isLastPage = true;
        appStore.setLoading(false);
      });
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    scrollController.dispose();
    buildInterstitialAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'lbl_add_coins_to_favourites'.translate,
            style: boldTextStyle(size: 20),
          ),
        ),
        body: Container(
          child: Stack(
            children: [
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 60),
                controller: scrollController,
                itemCount: mainList.length,
                itemBuilder: (context, index) {
                  return CryptoFollowWidget(
                    coin: mainList[index],
                    index: index + 1,
                    onSuccess: () {
                      setState(() {});
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 0,
                    thickness: 0.8,
                    indent: 60,
                    color: cardColor,
                  );
                },
              ),
              AppTextField(
                controller: controller,
                textFieldType: TextFieldType.OTHER,
                decoration: AppCommon.inputDecoration('lbl_search'.translate).copyWith(
                  suffixIcon: Icon(Icons.search, color: Colors.white),
                ),
                onChanged: (s) {
                  fetchCategoryData();
                },
              ).paddingSymmetric(horizontal: 16),
            ],
          ),
        ),
      ),
    );
  }
}
