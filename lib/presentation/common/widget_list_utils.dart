import 'package:flutter/material.dart';

List<Widget> separate<T>(
  List<T> items, {
  required Widget Function() separator,
  Widget Function(T, int index)? mapper,
  bool includeLast = false,
}) {
  final _mapper = mapper ?? (T item, int index) => item as Widget;

  return [
    for (int i = 0; i < items.length; i++) ...[
      _mapper(items[i], i),
      if (includeLast || i != items.length - 1) separator(),
    ]
  ];
}

List<Widget> pad(List<Widget> items, {required EdgeInsets padding}) {
  return items.map((e) => Padding(padding: padding, child: e)).toList();
}

List<Widget> wrap(List<Widget> items,
    {required Widget Function(Widget child) wrapper}) {
  return items.map((e) => wrapper(e)).toList();
}

extension ListSeparator on List<Widget> {
  List<Widget> separated(
      {required Widget Function() separator, bool includeLast = false}) {
    return separate(this, separator: separator, includeLast: includeLast);
  }

  List<Widget> padded(EdgeInsets padding) {
    return pad(this, padding: padding);
  }

  List<Widget> wrapped(Widget Function(Widget child) wrapper) {
    return wrap(this, wrapper: wrapper);
  }
}
