import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cryptocurrency_flutter/component/favorite_coin_component.dart';
import 'package:cryptocurrency_flutter/model/search_model.dart';
import 'package:cryptocurrency_flutter/network/local_db/sqflite_methods.dart';
import 'package:cryptocurrency_flutter/network/rest_api.dart';
import 'package:cryptocurrency_flutter/screens/dashboard_screen.dart';
import 'package:cryptocurrency_flutter/screens/news_screen.dart';
import 'package:cryptocurrency_flutter/screens/search_screen.dart';
import 'package:cryptocurrency_flutter/screens/setting_screen.dart';
import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  int currentIndex = 0;

  List<Widget> dashBoardPages = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    _controller.forward();

    dashBoardPages.add(DashboardScreen());
    dashBoardPages.add(SearchScreen());
    dashBoardPages.add(NewsScreen());
    dashBoardPages.add(SettingScreen());

    if (getBoolAsync(SharedPreferenceKeys.ADD_IS_FIRST, defaultValue: true)) {
      getCoinListForSearch.then((value) {
        setValue(SharedPreferenceKeys.ADD_IS_FIRST, false);
        value.coins.validate().forEach((element) {});
        Future.forEach(value.coins.validate(), (Coin element) async {
          await SqliteMethods.addCoins(element);
        });
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          elevation: 8,
          backgroundColor: secondaryColor,
          child: Icon(
            Icons.favorite_border,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {
            FavoriteCoinComponent().launch(context, pageRouteAnimation: PageRouteAnimation.Fade);
          },
        ),
        body: dashBoardPages[currentIndex],
        bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: [
            Icons.dashboard_outlined,
            Icons.search,
            Icons.featured_play_list_outlined,
            Icons.settings,
          ],
          onTap: (int) {
            currentIndex = int;
            setState(() {});
          },
          activeIndex: currentIndex,
          backgroundColor: cardColor,
          splashRadius: 0,
          leftCornerRadius: 20,
          rightCornerRadius: 20,
          elevation: 8,
          height: 70,
          activeColor: secondaryColor,
          splashSpeedInMilliseconds: 500,
          inactiveColor: Colors.white70,
          notchSmoothness: NotchSmoothness.softEdge,
          gapLocation: GapLocation.center,
        ),
      ),
    );
  }
}
