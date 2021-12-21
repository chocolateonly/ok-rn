import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';

void get defaultSetting {
  textPrimaryColorGlobal = Colors.white;
  textSecondaryColorGlobal = Colors.white60;
  shadowColorGlobal = Colors.grey.withOpacity(0.2);
  defaultInkWellSplashColor = secondaryColor.withOpacity(0.2);
  defaultInkWellHoverColor = secondaryColor.withOpacity(0.2);
  appButtonBackgroundColorGlobal = secondaryColor;
  defaultRadius = 8.0;
  defaultAppButtonRadius = 8.0;
  defaultAppButtonElevation = 0.0;
  defaultBlurRadius = 0.0;
  defaultSpreadRadius = 0.0;
  defaultAppBarElevation = 0.0;
  textBoldSizeGlobal = 16.0;
  textPrimarySizeGlobal = 16.0;
  textSecondarySizeGlobal = 14.0;
}

List<LanguageDataModel> get getAppLanguage {
  List<LanguageDataModel> list = [];
  list.add(LanguageDataModel(id: 0, name: "English", languageCode: 'en'));
  list.add(LanguageDataModel(id: 1, name: "Hindi", languageCode: 'hi'));
  list.add(LanguageDataModel(id: 2, name: "Gujarati", languageCode: 'gu'));
  list.add(LanguageDataModel(id: 3, name: "Dutch", languageCode: 'nl'));
  list.add(LanguageDataModel(id: 4, name: "French", languageCode: 'fr'));
  list.add(LanguageDataModel(id: 5, name: "Italian", languageCode: 'it'));
  list.add(LanguageDataModel(id: 6, name: "Bangla", languageCode: 'bn'));
  list.add(LanguageDataModel(id: 7, name: "Nepali", languageCode: 'ne'));
  list.add(LanguageDataModel(id: 8, name: "Japanese", languageCode: 'ja'));
  list.add(LanguageDataModel(id: 9, name: "Arabic", languageCode: 'ar'));
  list.add(LanguageDataModel(id: 10, name: "Portuguese", languageCode: 'pt'));
  list.add(LanguageDataModel(id: 11, name: "Russian", languageCode: 'ru'));
  list.add(LanguageDataModel(id: 12, name: "Danish", languageCode: 'da'));
  list.add(LanguageDataModel(id: 13, name: "Indonesian", languageCode: 'id'));
  list.add(LanguageDataModel(id: 14, name: "Tamil", languageCode: 'ta'));
  list.add(LanguageDataModel(id: 15, name: "Telugu", languageCode: 'te'));
  list.add(LanguageDataModel(id: 16, name: "Spanish", languageCode: 'es'));
  list.add(LanguageDataModel(id: 17, name: "Turkish", languageCode: 'tr'));

  return list;
}

BannerAd buildBannerAd() {
  return BannerAd(
    adUnitId: Admob.mAdMobBannerId,
    size: AdSize.fullBanner,
    listener: BannerAdListener(onAdLoaded: (ad) {
      //
    }),
    request: AdRequest(),
  );
}
