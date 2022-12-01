import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haishin_kit/audio_source.dart';
import 'package:haishin_kit/net_stream_drawable_texture.dart';
import 'package:haishin_kit/video_source.dart';

import '../controllers/live_class_controller.dart';

class LiveClassView extends GetView<LiveClassController> {
  const LiveClassView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('推流'), actions: [
        IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: () {
            if (controller.mode == "publish") {
              controller.mode = "playback";
              controller.rtmpStream?.attachVideo(null);
              controller.rtmpStream?.attachAudio(null);
            } else {
              controller.mode = "publish";
              controller.rtmpStream?.attachAudio(AudioSource());
              controller.rtmpStream?.attachVideo(
                  VideoSource(position: controller.currentPosition));
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.flip_camera_android),
          onPressed: () {
            if (controller.currentPosition == CameraPosition.front) {
              controller.currentPosition = CameraPosition.back;
            } else {
              controller.currentPosition = CameraPosition.front;
            }
            controller.rtmpStream?.attachVideo(
                VideoSource(position: controller.currentPosition));
          },
        )
      ]),
      body: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (c) => AlertDialog(
              title: Text("请输入推流码"),
              content: CupertinoTextField(
                controller: controller.textEditingController,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      controller.pushStream =
                          controller.textEditingController.text;
                      // controller.initPlatformState();
                      Get.back();
                    },
                    child: Text("确定"))
              ],
            ),
          );
        },
        child: Center(
          child: controller.rtmpStream == null
              ? const Text("")
              : NetStreamDrawableTexture(controller.rtmpStream),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: controller.recording
            ? const Icon(Icons.fiber_smart_record)
            : const Icon(Icons.not_started),
        onPressed: () {
          if (controller.recording) {
            print("停止推流");
            controller.rtmpConnection?.close();
            controller.recording = false;
            controller.update();
          } else {
            print("开始推流");
            controller.rtmpConnection
                ?.connect("rtmp://101.200.120.36:8086/live");
            print(controller.pushStream);
            controller.rtmpStream?.publish(controller.pushStream);
          }
        },
      ),
    );
  }
}
