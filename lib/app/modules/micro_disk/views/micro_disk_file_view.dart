import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import '../controllers/micro_disk_controller.dart';
import 'micro_disk_view.dart';

class MicroDiskFileView extends GetView<MicroDiskController> {
  const MicroDiskFileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('相册'),
          centerTitle: false,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.add)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(unselectedItemColor: Config.mainColor,selectedLabelStyle: TextStyle(color: Colors.grey,fontSize: 12),items: [

          BottomNavigationBarItem(icon:
          GestureDetector(onTap: () {
            Get.to(() => MicroDiskView());
          },child: Icon(Icons.source,color: Colors.grey,)),
              label: "文件"),
          BottomNavigationBarItem(icon: GestureDetector(onTap: () {
            Get.to(() => MicroDiskFileView());
          },child: Icon(Icons.picture_as_pdf_sharp,color: Config.mainColor,)),label: "相册"),
        ],

        ),
        body: Center(
       child: Text("相册"),
    ));}
}
