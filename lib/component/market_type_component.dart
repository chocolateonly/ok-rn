import 'package:cryptocurrency_flutter/main.dart';
import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:nb_utils/nb_utils.dart';

class MarketTypeComponent extends StatefulWidget {
  final DashboardType dashboardType;

  MarketTypeComponent({this.dashboardType = DashboardType.DASHBOARD_1});

  @override
  _MarketTypeComponentState createState() => _MarketTypeComponentState();
}

class _MarketTypeComponentState extends State<MarketTypeComponent> {
  int selectedValue = -1;
  ChartMarketType chartMarketType = ChartMarketType.PRICES;

  @override
  void initState() {
    selectedValue = getIntAsync(SharedPreferenceKeys.MARKET_TYPE_SELECTED_INDEX, defaultValue: 1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.dashboardType) {
      case DashboardType.DASHBOARD_1:
        return Container(
          width: context.width(),
          child: HorizontalList(
            itemCount: ChartMarketType.values.length,
            itemBuilder: (BuildContext context, int index) {
              bool isSelected = index == selectedValue;
              return Container(
                decoration: boxDecorationWithShadow(
                  backgroundColor: isSelected ? secondaryColor : cardColor,
                  borderRadius: radius(),
                ),
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  '${ChartMarketType.values[index].toString().splitAfter('.').capitalizeFirstLetter()}',
                  style: primaryTextStyle(size: 12),
                ),
              ).onTap(() {
                selectedValue = index;
                setValue(SharedPreferenceKeys.MARKET_TYPE_SELECTED_INDEX, index);
                chartStore.setSelectedChartMarketType(ChartMarketType.values[index]);

                setState(() {});
              });
            },
          ),
        );
      case DashboardType.DASHBOARD_2:
        return Container(
          child: Row(
            children: List.generate(ChartMarketType.values.length, (index) {
              ChartMarketType data = ChartMarketType.values[index];
              return Row(
                children: [
                  Radio<int>(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: index,
                      groupValue: selectedValue,
                      onChanged: (value) {
                        selectedValue = value.validate();
                        chartMarketType = data;
                        setState(() {});
                        setValue(SharedPreferenceKeys.MARKET_TYPE_SELECTED_INDEX, index);
                        chartStore.setSelectedChartMarketType(ChartMarketType.values[index]);
                      }),
                  Text(getName(data), style: primaryTextStyle()),
                ],
              );
            }),
          ),
        );
    }
  }

  String getName(ChartMarketType chartMarketType) {
    switch (chartMarketType) {
      case ChartMarketType.PRICES:
        return "lbl_mkt_cap".translate;
      case ChartMarketType.MARKET_CAPS:
        return "lbl_Prices".translate;
      case ChartMarketType.TOTAL_VOLUMES:
        return "lbl_total_vol".translate;
    }
  }
}
