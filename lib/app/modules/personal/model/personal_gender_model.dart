/// FileName personal_gender_model
///
/// @Author ke_zhang
/// @Date 2022/11/16 22:46
///
/// @Description 个人状态模型

class PersonalGender {
  PersonalGender({
    required this.genderName,
    required this.genderValue,
    this.isSelect,
  });

  final String genderName;
  final String genderValue;
  bool? isSelect;
}
