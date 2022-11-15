import 'package:flutter/material.dart';
/// FileName personal_info_model
///
/// @Author ke_zhang
/// @Date 2022/11/15 15:16
///
/// @Description TODO

class PersonalInfo {
  final String label;
  final String content;
  final VoidCallback onPress;

  PersonalInfo(this.label, this.content, this.onPress);
}
