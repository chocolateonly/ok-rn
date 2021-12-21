import 'package:cryptocurrency_flutter/component/coin_inteval_component.dart';
import 'package:cryptocurrency_flutter/component/coin_sorting_type_component.dart';
import 'package:cryptocurrency_flutter/main.dart';
import 'package:cryptocurrency_flutter/model/coin_list_model.dart';
import 'package:cryptocurrency_flutter/network/rest_api.dart';
import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:cryptocurrency_flutter/widgets/crypto_dashboard_widget.dart';
import 'package:cryptocurrency_flutter/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class CoinAllListScreen extends StatefulWidget {
  @override
  _CoinAllListScreenState createState() => _CoinAllListScreenState();
}

class _CoinAllListScreenState extends State<CoinAllListScreen> with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();

  int page = 1;
  List<CoinListModel> mainList = [];

  bool isEnabled = false;
  bool isLastPage = false;
  bool fabIsVisible = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    fetchAllCoinData(sortingOrder: selectedSortingType?.value.validate(), interval: selectedIntervalTypes?.value.validate());
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (!isLastPage) {
          page++;
          loadMoreData(sortingOrder: selectedSortingType?.value.validate(), interval: selectedIntervalTypes?.value.validate());
        }
      }
      scrollController.position.isScrollingNotifier.addListener(() {
        if (scrollController.position.isScrollingNotifier.value) {
          fabIsVisible = true;
        } else {
          fabIsVisible = false;
        }
      });
      setState(() {});
    });
  }

  Future fetchAllCoinData({String? sortingOrder, String? interval}) async {
    appStore.setLoading(true);
    getCoinList(page: page, currency: appStore.mSelectedCurrency!.cc.validate(), sortingOrder: sortingOrder!, interval: interval.validate(value: '1h')).then((value) {
      mainList.addAll(value);
      setState(() {});
    }).catchError((e) {
      toast(e.toString());
    }).whenComplete(() {
      appStore.setLoading(false);
    });
  }

  Future loadMoreData({String? sortingOrder, String? interval}) async {
    appStore.setLoading(true);
    await getCoinList(page: page, currency: appStore.mSelectedCurrency!.cc.validate(), sortingOrder: sortingOrder!, interval: interval!).then((value) {
      if (!mounted) return;
      appStore.setLoading(false);
      mainList.addAll(value);

      isLastPage = false;
      setState(() {});
    }).catchError((e) {
      isLastPage = true;
      toast(e.toString());
    }).whenComplete(() {
      appStore.setLoading(false);
    });
  }

  void animateToTop() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: AnimatedOpacity(
          opacity: isEnabled ? 0.0 : 1.0,
          duration: Duration(milliseconds: 1000),
          child: AnimatedOpacity(
            duration: 200.milliseconds,
            opacity: fabIsVisible ? 1 : 0,
            child: FloatingActionButton(
              onPressed: () {
                animateToTop();
              },
              backgroundColor: secondaryColor,
              child: Icon(Icons.vertical_align_top),
            ),
          ),
        ),
        appBar: AppBar(
          title: Text('lbl_crypto_coins'.translate, style: boldTextStyle()),
        ),
        body: Stack(
          children: [
            sortingWidget(),
            ListView.builder(
              padding: EdgeInsets.only(bottom: 60),
              itemCount: mainList.length,
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CryptoDashboardWidget(index: index, coinListModel: mainList[index]);
              },
            ).paddingTop(46),
            LoaderWidget().visible(appStore.mIsLoading.validate()),
          ],
        ),
      ),
    );
  }

  Widget sortingWidget() {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 8),
      child: Row(
        children: [
          Observer(
            builder: (_) => Container(
              child: TextIcon(
                text: coinStore.selectedSortType?.name.validate(),
                textStyle: primaryTextStyle(size: 14),
                suffix: Icon(Icons.arrow_downward_rounded, size: 16),
              ),
              decoration: boxDecorationDefault(color: secondaryColor),
            ).onTap(() async {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                backgroundColor: cardColor,
                builder: (context) {
                  return CoinSortingTypeComponent();
                },
              ).then((value) {
                if (value == true) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();

                  mainList.clear();

                  fetchAllCoinData(sortingOrder: selectedSortingType?.value.validate(), interval: selectedIntervalTypes?.value.validate());

                  setState(() {});
                } else {
                  //
                }
              }).catchError((e) {
                toast("error ${e.toString()}");
              });
            }),
          ),
          16.width,
          Observer(
            builder: (_) => Container(
              child: TextIcon(
                text: coinStore.selectedIntervalType?.name.validate(),
                textStyle: primaryTextStyle(size: 14),
                suffix: Icon(Icons.arrow_downward_rounded, size: 16),
              ),
              decoration: boxDecorationDefault(color: secondaryColor),
            ).onTap(() async {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                backgroundColor: cardColor,
                builder: (context) {
                  return CoinIntervalComponent();
                },
              ).then((value) {
                if (value == true) {
                  mainList.clear();

                  ScaffoldMessenger.of(context).hideCurrentSnackBar();

                  fetchAllCoinData(sortingOrder: selectedSortingType?.value.validate(), interval: selectedIntervalTypes?.value.validate());

                  setState(() {});
                } else {
                  //
                }
              }).catchError((e) {
                toast("Error ${e.toString()}");
              });
            }),
          ),
        ],
      ),
    );
  }
}
