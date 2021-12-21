import 'package:cryptocurrency_flutter/model/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';

class AppConstant {
  static const appName = "CryptoCoin";
  static const defaultLanguage = 'en';
  static const baseUrl = 'https://api.coingecko.com/api/v3/';
  static const perPage = 50;
  static const defaultGraphColor = Colors.orange;
  static const oneSignalAppID = '22144c24-fbd0-4ed8-807e-6ddf5b7fba04';
  static const defaultSortingOrderIndex = 2;
  static const defaultIntervalIndex = 0;
  static const btcSymbol = '₿';
  static const defaultChartMarketType = ChartMarketType.MARKET_CAPS;

  static CurrencyModel defaultCurrency = CurrencyModel(name: 'India', cc: 'inr', symbol: '₹');
}

class AppLists {
  static List<Color> gradientColor = [Colors.green, Colors.red, Colors.blue, Colors.orange, Colors.yellowAccent, Colors.deepPurple, Colors.lightGreen];
}

class Admob {
  static String mAdMobBannerId = BannerAd.testAdUnitId;
  static String mAdMobInterstitialId = InterstitialAd.testAdUnitId;
}

class SharedPreferenceKeys {
  static const DASHBOARD_DATA = "DASHBOARD_DATA";
  static const COIN_LIST = "COIN_LIST";
  static const TRENDING_DATA = "TRENDING_DATA";
  static const SELECTED_CURRENCY_INDEX = "SELECTED_CURRENCY_INDEX";
  static const SELECTED_CURRENCY = "SELECTED_CURRENCY";
  static const SELECTED_COLOR_INDEX = "SELECTED_COLOR";
  static const IS_FIRST = "IS_FIRST";
  static const CHART_DATA = "CHART_DATA";
  static const ADD_IS_FIRST = "ADD_IS_FIRST";
  static const MARKET_TYPE_SELECTED_INDEX = "MARKET_TYPE_SELECTED_INDEX";
  static const CHART_SELECTED_INDEX = "CHART_SELECTED_INDEX";
  static const DASHBOARD_SELECTED_INDEX = "DASHBOARD_SELECTED_INDEX";
  static const SORTING_ORDER_SELECTED_INDEX = "SORTING_ORDER_SELECTED_INDEX";
  static const DEFAULT_INTERVAL_SELECTED_INDEX = "DEFAULT_INTERVAL_SELECTED_INDEX";
}

class AppImages {
  static const walkThroughBackgroundImg = "images/app_images/walkthrough_background.jpg";
  static const gifWithName = "images/app_images/text_loader.gif";
  static const gifWithoutName = "images/app_images/loader_logo.gif";
  static const coinGecko = "images/app_images/coin_gecko_logo.png";
  static const decrementImage = "images/chart_images/decrement_arrow.png";
  static const incrementImage = "images/chart_images/increment_arrow.png";
  static const placeHolderImage = "images/app_images/loader_logo.png";
  static const walk1 = "images/app_images/walk1.png";
  static const walk2 = "images/app_images/walk2.png";
  static const walk3 = "images/app_images/walk3.png";
  static const candlestick = "images/chart_images/candlestick.png";
  static const line_chart = "images/chart_images/line_chart.png";
  static const facebookImg = "images/social_images/facebook.png";
  static const instagramImg = "images/social_images/instagram.png";
  static const linkedinImg = "images/social_images/linkedin.png";
  static const redditImg = "images/social_images/reddit.png";
  static const snapchatImg = "images/social_images/snapchat.png";
  static const twitterImg = "images/social_images/twitter.png";
  static const whatsappImg = "images/social_images/whatsapp.png";
  static const youtubeImg = "images/social_images/youtube.png";
  static const slackImg = "images/social_images/slack.png";
  static const telegramImg = "images/social_images/telegram.png";
  static const codeCanayonImg = "images/social_images/codecanayon.png";
  static const themeForestImg = "images/social_images/theme_forest.png";
  static const dribbbleImg = "images/social_images/dribbble.png";
  static const websiteImg = "images/social_images/website.png";
  static const area_chart = "images/chart_images/area_chart.jpg";
  static const candle_stick_chart = "images/chart_images/candle_stick_chart.jpg";
  static const derivativies = "images/chart_images/derivativites.png";
  static const dashboard1 = "images/chart_images/dashboard1.jpg";
  static const dashboard2 = "images/chart_images/dashboard2.jpg";
}

enum SocialMedia { TWITTER, FACEBOOK, INSTAGRAM, LINKEDIN }

class SocialMediaBaseUrl {
  static const telegramBaseUrl = "https://t.me/";
  static const twitterBaseUrl = "https://twitter.com/";
  static const facebookBaseUrl = "https://facebook.com/";
  static const instagramBaseUrl = "https://instagram.com/";
  static const linkedinBaseUrl = "";
  static const redditBaseUrl = "https://reddit.com/r/";
}

class Urls {
  static const appDescription =
      "The future is crypto currency exchange and we have build CryptoCoins Tracker Flutter App for digital currency investors, traders, and cryptocurrency experts. With a handful of features that can enhance your users’ crypto experience and even add value to their portfolio, CryptoCoins can keep you up-to-date with the latest trends and information. CryptoCoins is ideally designed and developed for lending platform providers to track change in rates. Keep a track of rates of coins in real-time with this Flutter app. You can find top trending coins of the day, search coins, turn to the latest news on crypto currency, review charts on your screen and get an overview of the digital currency market and listed coins at your comfort and ease with CryptoCoins App. With a multi-language support, you can create the most outstanding personalize user experience. CryptoCoins also gives its users ability to make decision at and cash out when the time is best.So, if you are a crypto currency trader, then CryptoCoins is the app every trader should have on their smartphone";
  static const copyRight = 'copyright @2021 IQONIC Design';
  static const packageName = "com.iqonic.cryptocoin";
  static const termsAndConditionURL = 'https://iqonic.design/tc/';
  static const supportURL = 'https://iqonic.desky.support/';
  static const codeCanyonURL = '';
  static const appShareURL = '$playStoreBaseURL$packageName';
  static const mailto = 'hello@iqonic.design';
  static const coinGeckoUrl = "https://www.coingecko.com/en";
  static const documentation = 'https://wordpress.iqonic.design/docs/product/cryptocoins/';
}

class IqonicUrls {
  static const Website = "https://iqonic.design/";
  static const Themeforest = "https://themeforest.net/user/iqonicdesign/portfolio";
  static const Codecanyon = "https://codecanyon.net/user/iqonicdesign/portfolio";
  static const Twitter = "https://twitter.com/iqonicdesign";
  static const Facebook = "https://www.facebook.com/iqonicdesign/";
  static const Dribbble = "https://dribbble.com/IqonicDesign";
  static const Instagram = "https://www.instagram.com/iqonicdesign/?hl=en";
}

//region All enums
enum ChartMarketType { PRICES, MARKET_CAPS, TOTAL_VOLUMES }
enum DashboardType { DASHBOARD_1, DASHBOARD_2 }
//end region
