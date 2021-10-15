import 'package:flutter/material.dart';
import 'package:flutter_study_demo/config/string_config.dart';
import 'package:flutter_study_demo/widget/simple_loading_widget.dart';

class LazyLoadBuilder extends StatelessWidget {
  final Function() onBuild;

  LazyLoadBuilder({this.onBuild}) : super();

  @override
  Widget build(BuildContext context) {
    if (onBuild != null) {
      onBuild();
    }
    return SimpleLoadingWidget(
      type: StringConfig.SIMPLE_CUPERTINO_LOADING_WIDGET,
    );
  }
}
