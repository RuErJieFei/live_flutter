import 'package:flutter/material.dart';

class BooleanObject {
  final String name;

  BooleanObject(this.name);

  @override
  bool operator ==(Object other) =>
      other is BooleanObject && name == other.name;

  @override
  int get hashCode => hashValues(name, name);
}

final yes = BooleanObject('Yes');
final no = BooleanObject('No');
