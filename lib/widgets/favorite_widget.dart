import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:cryptocurrency_flutter/main.dart';
import 'package:cryptocurrency_flutter/model/coin_detail_model.dart';
import 'package:cryptocurrency_flutter/network/rest_api.dart';
import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:cryptocurrency_flutter/utils/get_detail_view_currency.dart';
import 'package:cryptocurrency_flutter/widgets/cached_network_image.dart';
import 'package:cryptocurrency_flutter/widgets/increment_decrement_widget.dart';
import 'package:cryptocurrency_flutter/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class FavoriteWidget extends StatefulWidget {
  String coinId;
  Color color;

  FavoriteWidget({required this.coinId, required this.color});

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    //
  }

  @override
  Widget build(BuildContext context) {
    return SnapHelperWidget<CoinDetailModel>(
      loadingWidget: ShimmerWidget(width: context.width() / 2 - 26),
      future: getCoinDetail(name: widget.coinId.toString().validate()),
      onSuccess: (snap) {
        return Container(
          width: context.width() / 2 - 26,
          height: 250,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: radius(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  cachedImage(snap.image?.large.validate(), height: 30).cornerRadiusWithClipRRect(80),
                  16.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snap.name.validate(), style: boldTextStyle(size: 14)),
                      Text(snap.symbol.validate(), style: secondaryTextStyle(size: 14)),
                    ],
                  ).expand(),
                  16.width,
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: getPercentageValueInCurrency(snap.market_data!.price_change_percentage_1h_in_currency!).validate().getAmountForColor.withOpacity(0.2),
                    ),
                    child: IncrementDecrementWidget(
                      isDecrease: getPercentageValueInCurrency(snap.market_data!.price_change_percentage_1h_in_currency!).validate().isNegative,
                    ),
                  )
                ],
              ),
              16.height,
              Sparkline(
                data: snap.market_data!.sparkline_7d!.price!,
                lineColor: getPercentageValueInCurrency(snap.market_data!.price_change_percentage_1h_in_currency!).validate().getAmountForColor,
                // fillMode: FillMode.below,
                cubicSmoothingFactor: 1.0,
                useCubicSmoothing: true,
                sharpCorners: false,
                lineWidth: 0.5,
                fillGradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    getPercentageValueInCurrency(snap.market_data!.price_change_percentage_1h_in_currency!).validate().getAmountForColor,
                    getPercentageValueInCurrency(snap.market_data!.price_change_percentage_1h_in_currency!).validate().getAmountForColor
                  ],
                  stops: <double>[0.03, 0.9],
                ),
                fallbackHeight: 40,
                fallbackWidth: 160,
              ),
              16.height,
              TextIcon(
                prefix: IncrementDecrementWidget(
                  isDecrease: getPercentageValueInCurrency(snap.market_data!.price_change_percentage_1h_in_currency!).validate().isNegative,
                ),
                spacing: 6,
                text: "${getPercentageValueInCurrency(snap.market_data!.price_change_percentage_1h_in_currency!).validate()} %",
              ),
              Container(
                height: 3,
                width: 3,
                decoration: boxDecorationWithShadow(boxShape: BoxShape.circle),
              ),
              TextIcon(
                prefix: Text('', style: primaryTextStyle()),
                spacing: 6,
                textStyle: primaryTextStyle(),
                text: '${appStore.mSelectedCurrency!.symbol.validate()}${getPercentageValueInCurrency(snap.market_data!.current_price!).validate()} ',
              ),
            ],
          ),
        ).onTap(
          () {
            getSelectedDetailScreen(
              id: snap.id.validate(),
              name: snap.name.validate(),
              image: snap.image!.large.validate(),
            ).launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
          },
          borderRadius: radius(20),
        );
      },
    );
  }
}
