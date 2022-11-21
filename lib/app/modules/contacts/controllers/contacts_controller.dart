import 'package:authing_sdk/result.dart';
import 'package:flustars/flustars.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/modules/contacts/model/type_model.dart';
import 'package:wit_niit/main.dart';

class ContactsController extends GetxController {
  //TODO: Implement ContactsController

  final count = 0.obs;
  final _page = 0;
  final _size = 3;
  List<TypeModel>? list;

  ///获取通讯类型列表
  void getTypeList() async {
    var dataFrom = {"page": _page, "size": _size};
    request.post("/api/type/list", params: dataFrom).then((data) {
      List result = data['data'];
      list = result.map((e) => TypeModel.fromJson(e)).toList();
    });
  }

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

  void increment() => count.value++;
}
