import 'dart:math';

import 'package:conveyor_stadium/domain/models/fan_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stadium.freezed.dart';

@freezed
class Stadium with _$Stadium {
  const factory Stadium({
    required FanType type,
  }) = _Stadium;

  const Stadium._();

  String get imgPath {
    var path = "assets/images/";
    if (type.isOrange()) {
      path += "stadium_orange";
    } else if (type.isWhite()) {
      path += "stadium_white";
    } else if (type.isYellow()) {
      path += "stadium_yellow";
    }
    return "$path.png";
  }
}
