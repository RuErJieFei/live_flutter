import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haishin_kit/audio_settings.dart';
import 'package:haishin_kit/audio_source.dart';
import 'package:haishin_kit/rtmp_connection.dart';
import 'package:haishin_kit/rtmp_stream.dart';
import 'package:haishin_kit/video_settings.dart';
import 'package:haishin_kit/video_source.dart';
import 'package:permission_handler/permission_handler.dart';

class LiveClassController extends GetxController {
  //TODO: Implement LiveClassController

  RtmpConnection? rtmpConnection;
  RtmpStream? rtmpStream;
  bool recording = false;
  String mode = "publish";
  CameraPosition currentPosition = CameraPosition.back;

  String pushStream = "";

  TextEditingController textEditingController =
      TextEditingController(text: "xiaobang");

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    initPlatformState();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    rtmpStream?.dispose();
    rtmpConnection?.dispose();
  }

  Future<void> initPlatformState() async {
    await Permission.camera.request();
    await Permission.microphone.request();

    // Set up AVAudioSession for iOS.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth,
    ));

    RtmpConnection connection = await RtmpConnection.create();
    connection.eventChannel.receiveBroadcastStream().listen((event) {
      switch (event["data"]["code"]) {
        case 'NetConnection.Connect.Success':
          if (mode == "publish") {
            rtmpStream?.publish("live");
          } else {
            rtmpStream?.play("live");
          }
          recording = true;
          update();
          break;
      }
    });

    RtmpStream stream = await RtmpStream.create(connection);
    stream.audioSettings = AudioSettings(muted: false, bitrate: 64 * 1000);
    stream.videoSettings = VideoSettings(
      width: 480,
      height: 272,
      bitrate: 2500 * 1000,
    );
    stream.attachAudio(AudioSource());
    stream.attachVideo(VideoSource(position: currentPosition));

    rtmpConnection = connection;
    rtmpStream = stream;
    update();
  }
}
