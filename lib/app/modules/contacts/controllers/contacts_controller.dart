import 'package:get/get.dart';
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

  final _page = 0;
  final _size = 10;
  List<TypeModel> list = <TypeModel>[].obs;

  ///获取通讯类型列表
  void getTypeList() async {
    Map<String, int> params = {"page": _page, "size": _size};
    await request.post("/community/type/list", params: params).then((data) {
      List result = data['data'];
      list = result.map((e) => TypeModel.fromJson(e)).toList();
    });
  }
}
