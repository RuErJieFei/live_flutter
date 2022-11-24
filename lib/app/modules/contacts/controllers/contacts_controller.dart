import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/config/net_url.dart';
import 'package:wit_niit/app/modules/contacts/model/type_model.dart';
import 'package:wit_niit/main.dart';

class ContactsController extends GetxController {
  //TODO: Implement ContactsController

  @override
  void onInit() {
    super.onInit();
    getTypeList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final _page = 0.obs;
  final _size = 10.obs;
  List<TypeModel> list = <TypeModel>[].obs;

  ///获取通讯类型列表
  void getTypeList() async {
    Map<String, int> params = {"page": _page.value, "size": _size.value};
    await request
        .post("${NetUrl.message_HostName}/community/type/list", params: params)
        .then((data) {
      List result = data['data'];
      list.addAll(result.map((e) => TypeModel.fromJson(e)).toList());
    });
  }
}
