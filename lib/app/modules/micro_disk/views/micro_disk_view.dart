import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/theme_data.dart';
import '../controllers/micro_disk_controller.dart';
import 'micro_disk_file_view.dart';

class MicroDiskView extends GetView<MicroDiskController> {
  const MicroDiskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var flag1 = true.obs;
    var flag2 = false.obs;
    var flag3 = false.obs;
    var flag4 = true.obs;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {Get.back();}, icon: Icon(Icons.arrow_back)),
          title: const Text('文件'),
          centerTitle: false,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.add)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(selectedLabelStyle: TextStyle(color: Config.mainColor,fontSize: 12),items: [
          BottomNavigationBarItem(icon:
          GestureDetector(onTap: () {
            Get.to(() => MicroDiskView());
          },child: Icon(Icons.source)),
              label: "文件"),
          BottomNavigationBarItem(icon: GestureDetector(onTap: () {
            Get.to(() => MicroDiskFileView());
          },child: Icon(Icons.picture_as_pdf_sharp,)),label: "相册"),
        ],
        ),
        body: Obx(() {
          return Stack(children: [
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: TextButton(
                        onPressed: () {
                          flag1.value = true;
                          flag2.value = false;
                          flag3.value = false;
                        },
                        child: SizedBox(
                          height: 50.h,
                          child: Column(children: [
                            Text("最近查看"),
                            flag1.value
                                ? Divider(
                              thickness: 3,
                              indent: 25,
                              endIndent: 25,
                              color: Colors.blue,
                            )
                                : Divider()
                          ]),
                        ))),
                Expanded(
                    flex: 2,
                    child: TextButton(
                        onPressed: () {
                          flag1.value = false;
                          flag2.value = true;
                          flag3.value = false;
                        },
                        child: SizedBox(
                          height: 50.h,
                          child: Column(children: [
                            Text("微盘空间"),
                            flag2.value
                                ? Divider(
                                thickness: 3,
                                indent: 25,
                                endIndent: 25,
                                color: Colors.blue)
                                : Divider()
                          ]),
                        ))),
                Expanded(
                    flex: 2,
                    child: TextButton(
                        onPressed: () {
                          flag1.value = false;
                          flag2.value = false;
                          flag3.value = true;
                        },
                        child: SizedBox(
                          height: 50.h,
                          child: Column(children: [
                            Text("我分享的"),
                            flag3.value
                                ? Divider(
                                thickness: 3,
                                indent: 25,
                                endIndent: 25,
                                color: Colors.blue)
                                : Divider()
                          ]),
                        ))),
                Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 80.h,
                      child: Column(
                        children: [
                          flag1.value ?  IconButton(
                              onPressed: () {
                                flag4.value = !flag4.value;
                              }, icon: Icon(Icons.list)) : Container(),
                          Divider()
                        ],
                      ),
                    ))
              ],
            ),
            flag1.value ?  Padding(
              padding: const EdgeInsets.only(top: 50.0,),
              child: SizedBox(height:MediaQuery.of(context).size.height,
                  child: flag4.value ?  MicroDiskLatestContainer() :MicroDiskLatestContainer2(context) ),
            ): flag2.value ? Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Container(child: Text('微盘空间'),),
            ) : flag3.value ? Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Container(child: Text('我分享的'),),
            ) :Container()
          ]);
        }));
  }

  Widget MicroDiskLatestContainer() {
    return Container(
      child: ListView.separated(
          itemBuilder: (BuildContext context, index) {
            return ListTile(
              leading: controller.docList[index].leading,
              title: Text(controller.docList[index].title),
              subtitle: Text(controller.docList[index].subTitle),
              trailing: Icon(Icons.more_horiz_outlined),
            );
          },
          separatorBuilder: (context, index) => Divider(
            thickness: 1,
          ),
          itemCount: controller.docList.length),
    );
  }

  Widget MicroDiskLatestContainer2(BuildContext context) {
    return Container(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 220,
              childAspectRatio: 1.1,
             ),
          itemCount: controller.docList.length,
          itemBuilder: (BuildContext ctx, index) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100.h,
                    margin: EdgeInsets.only(bottom: 10.h),
                    child:controller.docList[index].leading,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                      ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.docList[index].title,overflow: TextOverflow.ellipsis,maxLines: 1,),
                            Text(controller.docList[index].subTitle),
                          ],
                        ),
                      ),
                      Expanded(flex: 1,child: Icon(Icons.more_horiz_outlined)),
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                border:new Border.all(width: 1),
              ),
            );
          }),
    );
  }
}
