import 'package:cryptocurrency_flutter/main.dart';
import 'package:cryptocurrency_flutter/model/news_response.dart';
import 'package:cryptocurrency_flutter/network/rest_api.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:cryptocurrency_flutter/widgets/loader_widget.dart';
import 'package:cryptocurrency_flutter/widgets/news_widget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  ScrollController scrollController = ScrollController();
  int page = 1;
  List<NewsData> mainList = [];

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    fetchAllNews();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (!isLastPage) {
          page++;
          loadMoreData();
        }
      }
    });
  }

  Future fetchAllNews() async {
    appStore.setLoading(true);
    getCryptoNews(page: page).then((value) {
      mainList.addAll(value.news!);
      setState(() {});
    }).catchError((e) {
      toast(e.toString());
    }).whenComplete(() {
      appStore.setLoading(false);
    });
  }

  Future loadMoreData() async {
    appStore.setLoading(true);
    await getCryptoNews(page: page).then((value) {
      if (!mounted) return;
      appStore.setLoading(false);
      mainList.addAll(value.news!);

      isLastPage = false;
      setState(() {});
    }).catchError((e) {
      isLastPage = true;
      toast(e.toString());
    }).whenComplete(() {
      appStore.setLoading(false);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('lbl_market_news'.translate, style: boldTextStyle(size: 22)),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 60),
          shrinkWrap: true,
          itemCount: mainList.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return NewsWidget(
              news: mainList[index],
            );
          },
        ),
      ).visible(!appStore.mIsLoading.validate(), defaultWidget: LoaderWidget()),
    );
  }
}
