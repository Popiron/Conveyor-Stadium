import 'package:flutter/material.dart';

enum BackgroundType { basic, clear, onlyUpArrows }

extension BackgroundTypeX on BackgroundType {
  bool get isBasic => this == BackgroundType.basic;
  bool get isClear => this == BackgroundType.clear;
  bool get isOnlyUpArrows => this == BackgroundType.onlyUpArrows;
  String get imgPath {
    if (isBasic) {
      return "assets/images/background.png";
    }
    if (isClear) {
      return "assets/images/background_clear.png";
    }
    if (isOnlyUpArrows) {
      return "assets/images/background_top_arrows.png";
    }
    return "";
  }
}

class Background extends StatelessWidget {
  final Widget child;
  final BackgroundType backgroundType;
  const Background({
    Key? key,
    required this.child,
    required this.backgroundType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            backgroundType.imgPath,
            fit: BoxFit.fill,
          ),
        ),
        child
      ],
    );
  }
}
