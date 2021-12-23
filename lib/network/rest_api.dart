import 'dart:convert';

import 'package:cryptocurrency_flutter/model/candel_chart_model.dart';
import 'package:cryptocurrency_flutter/model/coin_chart_model.dart';
import 'package:cryptocurrency_flutter/model/coin_detail_model.dart';
import 'package:cryptocurrency_flutter/model/coin_list_model.dart';
import 'package:cryptocurrency_flutter/model/currency_model.dart';
import 'package:cryptocurrency_flutter/model/dashboard_model.dart';
import 'package:cryptocurrency_flutter/model/derivatives_detail_model.dart';
import 'package:cryptocurrency_flutter/model/derivatives_response.dart';
import 'package:cryptocurrency_flutter/model/exchange_detail_model.dart';
import 'package:cryptocurrency_flutter/model/exchange_ticker_response.dart';
import 'package:cryptocurrency_flutter/model/exchnages_response.dart';
import 'package:cryptocurrency_flutter/model/news_response.dart';
import 'package:cryptocurrency_flutter/model/search_model.dart';
import 'package:cryptocurrency_flutter/model/trending_model.dart';
import 'package:cryptocurrency_flutter/network/network_utils.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

Future<List<CoinListModel>> getCoinList({String currency = 'usd', int page = 1, String sortingOrder = 'market_cap_desc', String interval = '1h'}) async {
  Iterable iterable = jsonDecode(await rootBundle.loadString('assets/markets.json'));
  List<CoinListModel> list = [];

  iterable.forEach((element) {
    list.add(CoinListModel.fromJson(element));
  });

  await setValue(SharedPreferenceKeys.COIN_LIST, jsonEncode(list));

  return list;
}

Future<TrendingModel> get getTrendingList async {
  var iterable = jsonDecode(await rootBundle.loadString('assets/trending.json'));

  TrendingModel td = TrendingModel.fromJson(iterable);
  await setValue(SharedPreferenceKeys.TRENDING_DATA, jsonEncode(td.toJson()));

  return td;
}

Future<CoinDetailModel> getCoinDetail({String? name}) async {
  var iterable = jsonDecode(await rootBundle.loadString('assets/yield_app_coins.json'));

  CoinDetailModel cd = CoinDetailModel.fromJson(iterable);
  return cd;
}

Future<CoinChartModel> getCoinMarket({String? name, int timeLimit = 1, String currency = ' usd'}) async {
  var iterable = jsonDecode(await rootBundle.loadString('assets/market_chart.json'));

  CoinChartModel cd = CoinChartModel.fromJson(iterable);

  return cd;
}

Future<List<CurrencyModel>> get getCurrencies async {
  Iterable iterable = jsonDecode(await rootBundle.loadString('assets/currency.json'));
  List<CurrencyModel> list = [];
  iterable.forEach((element) {
    list.add(CurrencyModel.fromJson(element));
  });
  return list;
}

Stream<DashboardResponse> dashboardStream({bool value = true, String currency = 'usd'}) async* {
  while (value) {
    await Future.delayed(Duration(milliseconds: 10000));
    DashboardResponse dashboardResponse = DashboardResponse();

    dashboardResponse.coinModel = await getCoinList(page: 1, currency: '$currency', interval: '1h');
    dashboardResponse.trendingCoins = await getTrendingList;

    yield dashboardResponse;
  }
}

Future<SearchModel> get getCoinListForSearch async {
  var iterable = jsonDecode(await rootBundle.loadString('assets/search.json'));
  return SearchModel.fromJson(iterable);
}

Future<NewsResponse> getCryptoNews({int page = 1}) async {
  var iterable = jsonDecode(await rootBundle.loadString('assets/news.json'));
  return NewsResponse.fromJson(iterable);
}

//region CachedData
DashboardResponse? getCachedUserDashboardData() {
  DashboardResponse dashboardResponse = DashboardResponse();

  String coinList = getStringAsync(SharedPreferenceKeys.COIN_LIST);
  String trendingData = getStringAsync(SharedPreferenceKeys.TRENDING_DATA);

  List<CoinListModel> list = [];
  jsonDecode(coinList).forEach((element) {
    list.add(CoinListModel.fromJson(element));
  });

  dashboardResponse.coinModel = list;
  dashboardResponse.trendingCoins = TrendingModel.fromJson(jsonDecode(trendingData));
  return dashboardResponse;
}

//endregion

Future<List<ExchangesResponse>> getExchanges({int page = 1}) async {
  Iterable iterable = jsonDecode(await rootBundle.loadString('assets/exchanges.json'));
  List<ExchangesResponse> list = [];

  iterable.forEach((element) {
    list.add(ExchangesResponse.fromJson(element));
  });

  return list;
}

Future<ExchangeDetailResponse> getExchangesDetail(String exchangeId) async {
  var iterable = jsonDecode(await rootBundle.loadString('assets/exchange_detail.json'));
  return ExchangeDetailResponse.fromJson(iterable);
}

Future<List> getExchangesChart({String? exchangeId = "binance", int interval = 1}) async {
  Iterable it = jsonDecode(await rootBundle.loadString('assets/volume_chart.json'));

  return it.toList();
}

Future<ExchangeTickerModel> getExchangesTickerList({String? exchangeId = "binance", int page = 1}) async {
  var iterable = jsonDecode(await rootBundle.loadString('assets/tickers.json'));
  return ExchangeTickerModel.fromJson(iterable);
}

class DerivativesApi {
  static Future<List<DerivativesResponse>> getDerivativesList({int page = 1}) async {
    Iterable iterable = jsonDecode(await rootBundle.loadString('assets/derivatives.json'));
    List<DerivativesResponse> list = [];

    iterable.forEach((element) {
      list.add(DerivativesResponse.fromJson(element));
    });

    return list;
  }

  static Future<DerivativesDetailResponse> getDerivativesDetail({String? id}) async {
    var iterable = jsonDecode(await rootBundle.loadString('assets/derivatives_detail.json'));
    return DerivativesDetailResponse.fromJson(iterable);
  }
}

class ChartApi {
  static Future<List<CandleChartResponse>> getOLHCChart({String? coinId, String currency = 'inr', int days = 1}) async {
    Iterable it = jsonDecode(await rootBundle.loadString('assets/ohlc.json'));

    List<CandleChartResponse> data = [];

    it.forEach((element) {
      data.add(CandleChartResponse(time: element[0], open: element[1], high: element[2], low: element[3], close: element[4]));
    });

    return data;
  }
}
