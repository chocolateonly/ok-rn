import 'dart:convert';

import 'package:cryptocurrency_flutter/model/currency_model.dart';
import 'package:cryptocurrency_flutter/model/default_setting.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

part 'AppStore.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  LanguageDataModel? selectedLanguage;

  @observable
  Color mSelectedGraphColor = AppConstant.defaultGraphColor;

  @observable
  ChartMarketType mSelectedMarketType = AppConstant.defaultChartMarketType;

  @observable
  DefaultSetting? mDashboardType;

  @observable
  DefaultSetting? mDefaultChart;

  @observable
  CurrencyModel? mSelectedCurrency;

  @observable
  bool? mIsLoading;

  @action
  Future setSelectedGraphColor(Color aColor) async => mSelectedGraphColor = aColor;

  @action
  Future setSelectedMarketType(ChartMarketType aType) async => mSelectedMarketType = aType;

  @action
  Future setSelectedDashboard(DefaultSetting aType) async => mDashboardType = aType;

  @action
  Future setSelectedDefaultChart(DefaultSetting aType) async => mDefaultChart = aType;

  @action
  Future setLoading(bool aIsLoading) async => mIsLoading = aIsLoading;

  @action
  Future<CurrencyModel> setSelectedCurrency(CurrencyModel aSelectedCurrency) async {
    setValue(SharedPreferenceKeys.SELECTED_CURRENCY, jsonEncode(aSelectedCurrency));

    return mSelectedCurrency = aSelectedCurrency;
  }

  @action
  Future<void>? setLanguage(String? aCode) {
    log("Selected language $aCode");
    selectedLanguageDataModel = getSelectedLanguageModel(defaultLanguage: AppConstant.defaultLanguage);
    selectedLanguage = getSelectedLanguageModel(defaultLanguage: AppConstant.defaultLanguage);
    return null;
  }
}
