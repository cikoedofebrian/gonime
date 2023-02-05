import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.staggeredDotsWave(color: color, size: 40);
  }
}
