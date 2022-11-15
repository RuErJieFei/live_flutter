import 'package:flutter/material.dart';
import 'package:wit_niit/app/data/school_theme_data.dart';

/// FileName choice_chip_multiple
///
/// @Author chenrongqi
/// @Date 2022/11/14 17:11
///
/// @Description 单选choiceChip
class ChoiceChipSelect extends StatelessWidget {
  const ChoiceChipSelect(
      {required this.index,
      required this.selected,
      required this.choice,
      required this.fun})
      : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ChoiceChip(
        label: Text(choice),
        selectedColor: SchoolConfig.primaryColor,
        //被禁用得时候背景
        disabledColor: Colors.grey[250],
        labelStyle: TextStyle(
            fontWeight: FontWeight.w200, fontSize: 15.0, color: Colors.white),
        labelPadding: EdgeInsets.only(left: 8.0, right: 8.0),
        materialTapTargetSize: MaterialTapTargetSize.padded,
        onSelected: fun,
        selected: selected == index,
      ),
    );
  }

  final int index;
  final selected;
  final String choice;
  final Function(bool value) fun;
}
