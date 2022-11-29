
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:wit_niit/app/modules/bench/controllers/schedule_controller.dart';

class HomeContent extends GetView<SchedulePageController> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FutureBuilder(
          future: controller.initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            print(snapshot.connectionState);
            if (snapshot.hasError) print(snapshot.error);
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                // aspectRatio: 16 / 9,
                aspectRatio: controller.videoContro.value.value.aspectRatio,
                child: VideoPlayer(controller.videoContro.value),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        SizedBox(height: 30),
        Obx(() {
          return ElevatedButton(
            child: Icon(
              controller.videoContro.value.value.isPlaying ? Icons.pause : Icons
                  .play_arrow,
            ),
            onPressed: () {
              print( controller.videoContro.value.value.isPlaying);
              if (controller.videoContro.value.value.isPlaying == false) {
                controller.videoContro.value.pause();
              } else {
                // If the video is paused, play it.
                controller.videoContro.value.play();

              }
            },
          );
        })
      ],
    );
  }
}
