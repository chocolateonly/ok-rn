import 'package:cryptocurrency_flutter/model/derivatives_response.dart';
import 'package:cryptocurrency_flutter/screens/derivatives_detail_screen.dart';
import 'package:cryptocurrency_flutter/utils/app_common.dart';
import 'package:cryptocurrency_flutter/utils/app_constant.dart';
import 'package:cryptocurrency_flutter/widgets/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DerivativesWidget extends StatefulWidget {
  final DerivativesResponse? data;

  DerivativesWidget({this.data});

  @override
  _DerivativesWidgetState createState() => _DerivativesWidgetState();
}

class _DerivativesWidgetState extends State<DerivativesWidget> {
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
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              cachedImage(widget.data?.image, height: 35, width: 35).cornerRadiusWithClipRRect(80),
              16.width,
              Text(widget.data!.name.toString(), style: boldTextStyle()),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('lbl_24h_vol'.translate, style: primaryTextStyle(size: 12)),
                  8.width,
                  Text('${AppConstant.btcSymbol}${widget.data!.trade_volume_24h_btc.toString().validate()}', style: primaryTextStyle()),
                ],
              ),
              Row(
                children: [
                  Text('lbl_open_int'.translate, style: primaryTextStyle(size: 12)),
                  8.width,
                  Text('${AppConstant.btcSymbol}${widget.data!.open_interest_btc.toString().validate()}', style: primaryTextStyle()),
                ],
              ),
            ],
          ),
        ],
      ),
    ).onTap(() {
      DerivativesDetailScreen(data: widget.data).launch(context);
    });
  }
}
