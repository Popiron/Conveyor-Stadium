import 'dart:math';

import 'package:conveyor_stadium/domain/models/direction.dart';
import 'package:conveyor_stadium/domain/models/fan_type.dart';
import 'package:conveyor_stadium/domain/models/sex.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fan.freezed.dart';

@freezed
class Fan with _$Fan {
  const factory Fan(
      {required FanType type,
      required Sex sex,
      @Default(Direction.forward) Direction direction}) = _Fan;

  factory Fan.random() {
    final Random random = Random();
    final rtype = FanType.values[random.nextInt(3)];
    final rsex = Sex.values[random.nextInt(2)];
    return Fan(type: rtype, sex: rsex);
  }

  const Fan._();

  String get imgPath {
    var path = "assets/images/";
    if (type.isOrange()) {
      path += "fan_orange";
    } else if (type.isWhite()) {
      path += "fan_white";
    } else if (type.isYellow()) {
      path += "fan_yellow";
    }
    if (sex.isFemale) {
      path += "_f";
    } else {
      path += "_m";
    }
    return "$path.png";
  }

  // set direction(Direction d) {
  //   direction = d;
  // }
}
