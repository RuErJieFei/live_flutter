import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/base_style.dart';
import 'package:wit_niit/app/modules/wit_classroom/controllers/add_device_controller.dart';

class AddDeviceView extends GetView<AddDeviceController> {
  const AddDeviceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加设备'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Obx(() {
              return GridView.custom(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => controller
                            .addDevice(controller.deviceTypeList[index].id!),
                        child: Card(
                          elevation: 8,
                          shadowColor: Colors.black.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: Text(
                                controller.deviceTypeList[index].typeName ?? '',
                                style: BaseStyle.grayBoldBigContentStyle,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: controller.deviceTypeList.length,
                  ));
            }),

            // itemCount: controller.deviceTypeList.length,
            // itemBuilder: (context, index) {
            //   return Card(
            //     elevation: 8,
            //     shadowColor: Colors.black.withOpacity(0.3),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(20.0),
            //       child:
            //           Text(controller.deviceTypeList[index].typeName ?? ''),
            //     ),
            //   );
            // })
            // Container(
            //   decoration: BoxDecoration(),
            // ),
          ],
        ),
      ),
    );
  }
}
