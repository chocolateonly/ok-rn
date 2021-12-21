import 'package:cryptocurrency_flutter/component/date_picker_for_chart.dart';
import 'package:cryptocurrency_flutter/main.dart';
import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class MarketTypeBasedOnDateComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        String getText() {
          String value;
          if (chartStore.mIsDateSelected == true) {
            value = '${'lbl_selected_range'.translate} [${chartStore.mFromDate?.toString().getFormattedDate} to ${chartStore.mToDate?.toString().getFormattedDate} ] ';
          } else {
            value = 'lbl_select_range'.translate;
          }
          return value;
        }

        return Container(
          child: TextIcon(
            text: getText(),
            onTap: () {
              showModalBottomSheet(
                backgroundColor: cardColor,
                context: context,
                builder: (context) {
                  return DatePickerForChart();
                },
              );
            },
          ),
        );
      },
    );
  }
}
