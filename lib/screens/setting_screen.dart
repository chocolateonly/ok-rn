import 'package:cryptocurrency_flutter/main.dart';
import 'package:cryptocurrency_flutter/screens/about_us_screen.dart';
import 'package:cryptocurrency_flutter/screens/currency_selection_screen.dart';
import 'package:cryptocurrency_flutter/screens/default_setting_screen.dart';
import 'package:cryptocurrency_flutter/screens/language_selection_screen.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:cryptocurrency_flutter/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
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
    appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('lbl_setting'.translate, style: boldTextStyle(size: 22)),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SettingItemWidget(
                onTap: () {
                  CurrencySelectionScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                },
                leading: Icon(Icons.money),
                padding: EdgeInsets.all(16),
                title: "lbl_Currency".translate,
                trailing: Observer(
                  builder: (_) => TextIcon(text: "${appStore.mSelectedCurrency!.name.validate()} (${appStore.mSelectedCurrency!.symbol.validate()})", suffix: Icon(Icons.arrow_forward_ios_outlined, size: 12), textStyle: secondaryTextStyle()),
                ),
              ),
              SettingItemWidget(
                leading: Icon(Icons.language_outlined),
                title: "lbl_App_Language".translate,
                onTap: () {
                  appLocalizations = AppLocalizations.of(context);

                  LanguageSelectionScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide).then((value) {
                    setState(() {});
                  });
                },
                padding: EdgeInsets.all(16),
                trailing: TextIcon(text: selectedLanguageDataModel!.name.validate(), suffix: Icon(Icons.arrow_forward_ios_outlined, size: 12), textStyle: secondaryTextStyle()),
              ),
              SettingItemWidget(
                onTap: () {
                  DefaultSettingScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                },
                leading: Icon(Icons.notifications_none_rounded),
                title: "lbl_default_settings".translate,
                padding: EdgeInsets.all(16),
                trailing: TextIcon(text: '', suffix: Icon(Icons.arrow_forward_ios_outlined, size: 12), textStyle: secondaryTextStyle()),
              ),
              SettingItemWidget(
                leading: Icon(Icons.person_outline),
                title: "lbl_About_us".translate,
                padding: EdgeInsets.all(16),
                trailing: TextIcon(text: '', suffix: Icon(Icons.arrow_forward_ios_outlined, size: 12), textStyle: secondaryTextStyle()),
                onTap: () {
                  AboutUsScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                },
              ),
              SettingItemWidget(
                leading: Icon(Icons.star_border),
                padding: EdgeInsets.all(16),
                title: "lbl_Rate_us".translate,
                onTap: () {
                  AppCommon.launchUrl(Urls.appShareURL);
                },
              ),
              SettingItemWidget(
                leading: Icon(Icons.insert_drive_file),
                title: "lbl_Terms_and_condition".translate,
                padding: EdgeInsets.all(16),
                onTap: () {
                  AppCommon.launchUrl(Urls.termsAndConditionURL, forceWebView: true);
                },
              ),
              SettingItemWidget(
                leading: Icon(Icons.share),
                title: "lbl_Share".translate,
                padding: EdgeInsets.all(16),
                onTap: () {
                  Share.share('Share ${AppConstant.appName} app\n\n${Urls.appShareURL}');
                },
              ),
              SnapHelperWidget<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                onSuccess: (data) {
                  return SettingItemWidget(
                    leading: Icon(Icons.verified_rounded),
                    title: "lbl_Version".translate,
                    padding: EdgeInsets.all(16),
                    trailing: Text(data.version.validate(), style: secondaryTextStyle(size: 16)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
