import 'package:flutter/material.dart';
import 'package:tatsam/Utils/size_utils/size_utils.dart';
import 'package:tatsam/commonWidget/circular_indicator.dart';

class ProgressBarRound extends StatelessWidget {
  const ProgressBarRound({
    Key? key,
    required this.isLoading,
  }) : super(key: key);

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return Visibility(
      visible: isLoading,
      child: Container(
        child: Indicator.screenProgressIndicator(context),
      ),
    );
  }
}
