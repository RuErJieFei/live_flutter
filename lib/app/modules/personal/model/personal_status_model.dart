/// FileName personal_status_model
///
/// @Author ke_zhang
/// @Date 2022/11/16 22:46
///
/// @Description 个人状态模型

class PersonalStatus {
  PersonalStatus({
    required this.statusIcon,
    required this.statusLabel,
    this.isSelect,
  });

  final String statusIcon;
  final String statusLabel;
  bool? isSelect;
}
