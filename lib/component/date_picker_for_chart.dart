import 'package:cryptocurrency_flutter/main.dart';
import 'package:cryptocurrency_flutter/utils/app_colors.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class DatePickerForChart extends StatefulWidget {
  @override
  _DatePickerForChartState createState() => _DatePickerForChartState();
}

class _DatePickerForChartState extends State<DatePickerForChart> {
  String mFromDate = "lbl_from".translate;
  String mToDate = "lbl_to".translate;

  DateTime? fromDate;
  DateTime? toDate;

  int differences = 1;
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, bottom: 32, right: 16, top: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 2, width: 36, decoration: boxDecorationDefault(borderRadius: radius())).center(),
          16.height,
          Row(
            children: [
              Text('lbl_select_Date'.translate, style: boldTextStyle()).expand(),
              TextIcon(
                text: 'lbl_reset'.translate,
                onTap: () {
                  fromDate = null;
                  toDate = null;
                  chartStore.setIsDateSelected(false);
                  chartStore.setRangeDifference(1);
                  finish(context);
                },
              )
            ],
          ),
          16.height,
          Container(
            width: context.width(),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(border: Border.all(color: context.dividerColor), borderRadius: radius()),
            child: Text(fromDate == null ? mFromDate : fromDate.toString().getFormattedDate, style: primaryTextStyle()),
          ).onTap(
            () async {
              fromDate = await buildShowDatePicker(context, helpText: 'lbl_from'.translate, initialDate: chartStore.mFromDate == null ? DateTime.now() : chartStore.mFromDate);
              if (toDate == null) {
                await 150.milliseconds.delay;
                toDate = await buildShowDatePicker(context, helpText: 'lbl_to'.translate, initialDate: chartStore.mToDate == null ? DateTime.now() : chartStore.mToDate);
              }
              if (!toDate!.difference(fromDate!).inDays.isNegative) {
                if (fromDate != null && toDate != null) {
                  differences = toDate!.difference(fromDate!).inDays;
                }
              } else {
                toast("lbl_invalid_date_range".translate);
                fromDate = null;
                toDate = null;
              }
              setState(() {});
            },
          ),
          16.height,
          Container(
            width: context.width(),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(border: Border.all(color: context.dividerColor), borderRadius: radius()),
            child: Text(toDate == null ? mToDate : toDate.toString().getFormattedDate, style: primaryTextStyle()),
          ).onTap(() async {
            if (fromDate != null) {
              toDate = await buildShowDatePicker(context, helpText: 'lbl_to'.translate, initialDate: chartStore.mToDate == null ? DateTime.now() : chartStore.mToDate);
              if (!toDate!.difference(fromDate!).inDays.isNegative) {
                if (fromDate != null && toDate != null) {
                  differences = toDate!.difference(fromDate!).inDays;
                }
              } else {
                toast("Invalid date range");
                fromDate = null;
                toDate = null;
              }
              setState(() {});
            } else {
              toast("lbl_select_from_date_first".translate);
            }
          }),
          16.height,
          AppButton(
            width: context.width(),
            text: "lbl_confirm".translate,
            onTap: () {
              finish(context);
              chartStore.setFromDate(fromDate!);
              chartStore.setToDate(toDate!);
              chartStore.setRangeDifference(differences);
            },
          ),
        ],
      ),
    );
  }

  Future<DateTime?> buildShowDatePicker(BuildContext context, {String helpText = '', DateTime? initialDate}) {
    return showDatePicker(
      context: context,
      initialDate: initialDate == null ? DateTime.now() : initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: helpText.validate(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: secondaryColor,
              onPrimary: Colors.white,
              surface: secondaryColor,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: cardColor,
          ),
          child: child!,
        );
      },
    );
  }
}
