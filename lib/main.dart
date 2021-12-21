import 'dart:convert';

import 'package:cryptocurrency_flutter/model/coin_sorting_model.dart';
import 'package:cryptocurrency_flutter/model/currency_model.dart';
import 'package:cryptocurrency_flutter/model/default_setting.dart';
import 'package:cryptocurrency_flutter/screens/splash_screen.dart';
import 'package:cryptocurrency_flutter/store/AppStore.dart';
import 'package:cryptocurrency_flutter/store/ChartStore.dart';
import 'package:cryptocurrency_flutter/store/CoinStore.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:cryptocurrency_flutter/utils/app_functions.dart';
import 'package:cryptocurrency_flutter/utils/app_localizations.dart';
import 'package:cryptocurrency_flutter/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sqflite/sqflite.dart';

AppStore appStore = AppStore();
ChartStore chartStore = ChartStore();
CoinStore coinStore = CoinStore();
AppLocalizations? appLocalizations;
Database? localDbInstance;

SortingTypeModel? selectedSortingType;
SortingTypeModel? selectedIntervalTypes;

int mAdShowCount = 0;

List<DefaultSetting> getDashboard = DefaultSetting.getDashboardCharts;
List<DefaultSetting> getMarketType = DefaultSetting.getChartMarketDefaultType;
List<DefaultSetting> getCharts = DefaultSetting.getDefaultCharts;

OneSignal oneSignal = OneSignal();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (isMobile) {
    await Firebase.initializeApp();
  }

  Function? originalOnError = FlutterError.onError;

  FlutterError.onError = (FlutterErrorDetails errorDetails) async {
    await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    originalOnError!(errorDetails);
  };
  defaultSetting;

  await initialize(aLocaleLanguageList: getAppLanguage);

  appStore.setLanguage(getStringAsync(SELECTED_LANGUAGE_CODE, defaultValue: AppConstant.defaultLanguage));
  appStore.setSelectedCurrency(CurrencyModel.fromJson(jsonDecode(getStringAsync(SharedPreferenceKeys.SELECTED_CURRENCY, defaultValue: jsonEncode(AppConstant.defaultCurrency)))));
  appStore.setSelectedGraphColor(AppLists.gradientColor[getIntAsync(SharedPreferenceKeys.SELECTED_COLOR_INDEX)]);
  appStore.setSelectedMarketType(ChartMarketType.values[getIntAsync(SharedPreferenceKeys.MARKET_TYPE_SELECTED_INDEX)]);
  appStore.setSelectedDashboard(getDashboard[getIntAsync(SharedPreferenceKeys.DASHBOARD_SELECTED_INDEX, defaultValue: 0)]);
  appStore.setSelectedDefaultChart(getCharts[getIntAsync(SharedPreferenceKeys.CHART_SELECTED_INDEX, defaultValue: 0)]);

  coinStore.setSelectedSortType(getIntAsync(SharedPreferenceKeys.SORTING_ORDER_SELECTED_INDEX, defaultValue: AppConstant.defaultSortingOrderIndex));
  coinStore.setSelectedIntervalType(getIntAsync(SharedPreferenceKeys.DEFAULT_INTERVAL_SELECTED_INDEX, defaultValue: AppConstant.defaultIntervalIndex));

  if (isMobile) {
    await oneSignal.setAppId(AppConstant.oneSignalAppID);

    OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent? event) {
      return event?.complete(event.notification);
    });

    oneSignal.disablePush(false);
    oneSignal.consentGranted(true);
    oneSignal.requiresUserPrivacyConsent();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        title: AppConstant.appName,
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: SplashScreen(),
        supportedLocales: LanguageDataModel.languageLocales(),
        localizationsDelegates: [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
        localeResolutionCallback: (locale, supportedLocales) => locale,
        locale: Locale(appStore.selectedLanguage!.languageCode.validate(value: AppConstant.defaultLanguage)),
        scrollBehavior: SBehavior(),
      ),
    );
  }
}
