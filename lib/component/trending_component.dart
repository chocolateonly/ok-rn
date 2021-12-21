import 'package:cryptocurrency_flutter/model/trending_model.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:cryptocurrency_flutter/widgets/trending_widget.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class TrendingComponent extends StatefulWidget {
  TrendingModel data;

  TrendingComponent({required this.data});

  @override
  _TrendingComponentState createState() => _TrendingComponentState();
}

class _TrendingComponentState extends State<TrendingComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('lbl_trending_crypto'.translate, style: boldTextStyle(size: 18)).paddingAll(16),
          HorizontalList(
            itemCount: widget.data.coins!.length,
            spacing: 16,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: 16, right: 16),
            itemBuilder: (context, index) {
              return TrendingWidget(trendingItemData: widget.data.coins![index].item!, color: AppLists.gradientColor[index]);
            },
          ),
        ],
      ),
    );
  }
}
