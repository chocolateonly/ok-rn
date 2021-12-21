import 'package:cryptocurrency_flutter/model/search_model.dart';
import 'package:cryptocurrency_flutter/network/local_db/sqflite_methods.dart';
import 'package:cryptocurrency_flutter/screens/add_crypto_screen.dart';
import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:cryptocurrency_flutter/utils/app_functions.dart';
import 'package:cryptocurrency_flutter/widgets/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';

class FavoriteCoinComponent extends StatefulWidget {
  @override
  _FavoriteCoinComponentState createState() => _FavoriteCoinComponentState();
}

class _FavoriteCoinComponentState extends State<FavoriteCoinComponent> {
  BannerAd? myBanner;
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    myBanner = buildBannerAd()..load();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('lbl_favorite_coins'.translate, style: boldTextStyle()),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                AddCryptoScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide).then((value) {
                  setState(() {});
                });
              },
            ),
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            SnapHelperWidget<List<Coin>>(
              future: SqliteMethods.getFavoriteCoins(),
              onSuccess: (snap) {
                if (snap.length == 0) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${'lbl_you_have_no_favourites'.translate} :(", style: boldTextStyle()).center(),
                    ],
                  );
                }
                return Wrap(
                  runSpacing: 16,
                  spacing: 16,
                  children: List.generate(snap.length, (index) {
                    Coin data = snap[index];
                    return Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: radius(8),
                      ),
                      width: context.width() / 2 - 16,
                      child: Row(
                        children: [
                          cachedImage(data.large.validate(), height: 30).cornerRadiusWithClipRRect(80),
                          16.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${data.name.validate()}", style: primaryTextStyle(), maxLines: 2),
                              Text(data.symbol.validate(), style: secondaryTextStyle(size: 14)),
                            ],
                          ).expand(),
                          IconButton(
                              onPressed: () {
                                SqliteMethods.updateFavoriteStatus(0, data).then((value) {
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  snackBar(
                                    context,
                                    title: '${'lbl_removed'.translate} ${data.name} ${'lbl_from_favorite'.translate}',
                                  );
                                  setState(() {});
                                }).catchError((e) {
                                  log(e.toString());
                                });
                              },
                              icon: Icon(Icons.close, color: Colors.red))
                        ],
                      ),
                    ).onTap(
                      () {
                        getSelectedDetailScreen(
                          name: data.name.validate(),
                          id: data.id.validate(),
                          image: data.large.validate(),
                        ).launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                      },
                      borderRadius: radius(20),
                    );
                  }),
                ).paddingSymmetric(horizontal: 8);
              },
            ),
            if (myBanner != null)
              Positioned(
                child: AdWidget(ad: myBanner!),
                bottom: 0,
                left: 0,
                right: 0,
                height: AdSize.banner.height.toDouble(),
              ),
          ],
        ),
      ),
    );
  }
}
