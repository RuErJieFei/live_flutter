import 'dart:math';

import 'package:audio_session/audio_session.dart';
import 'package:dio/dio.dart' as d;
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:haishin_kit/audio_settings.dart';
import 'package:haishin_kit/audio_source.dart';
import 'package:haishin_kit/net_stream_drawable_texture.dart';
import 'package:haishin_kit/rtmp_connection.dart';
import 'package:haishin_kit/rtmp_stream.dart';
import 'package:haishin_kit/video_settings.dart';
import 'package:haishin_kit/video_source.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../login/model/user_model.dart';

/**
 * 推流
 */
class LiveView extends StatefulWidget {
  const LiveView({Key? key}) : super(key: key);

  @override
  State<LiveView> createState() => _LiveViewState();
}

class _LiveViewState extends State<LiveView> {
  RtmpConnection? _connection;
  RtmpStream? _stream;
  bool _recording = false;
  String _mode = "publish";
  CameraPosition currentPosition = CameraPosition.front;
  String pushStream = "";
  TextEditingController classController = TextEditingController(text: "");
  List<String> covers = [
    'http://124.221.232.15:9090/hlh/下载.jpeg',
    'http://124.221.232.15:9090/hlh/Snipaste_2022-11-30_14-31-43.png',
    'http://124.221.232.15:9090/hlh/Snipaste_2022-11-30_14-38-42.png',
    'http://124.221.232.15:9090/hlh/Snipaste_2022-11-30_14-38-56.png',
    'http://124.221.232.15:9090/hlh/Snipaste_2022-11-30_14-55-24.png',
  ];
  bool start = false;
  String roomId = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      initPlatformState();
    });
  }

  @override
  void deactivate() {
    _stream?.dispose();
    _connection?.dispose();
    super.deactivate();
  }

  @override
  void dispose() {
    _stream?.dispose();
    _connection?.dispose();
    closeLive();
    super.dispose();
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
          if (_mode == "publish") {
            _stream?.publish("live");
          } else {
            _stream?.play("live");
          }
          setState(() {
            _recording = true;
          });
          break;
      }
    });

    RtmpStream stream = await RtmpStream.create(connection);
    stream.audioSettings = AudioSettings(muted: false, bitrate: 64 * 1000);
    stream.videoSettings = VideoSettings(
      width: 390,
      height: 844,
      bitrate: 2500 * 1000,
    );
    stream.attachAudio(AudioSource());
    stream.attachVideo(VideoSource(position: currentPosition));

    if (!mounted) return;

    setState(() {
      _connection = connection;
      _stream = stream;
    });
  }

  closeLive() async {
    d.Dio dio = d.Dio();
    d.Response res = await dio.post(
        'http://121.40.208.79:10000/api/v1/live/room/close',
        queryParameters: {'roomId': roomId});
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: _stream == null
              ? Container()
              : Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    NetStreamDrawableTexture(_stream),
                    start
                        ? Positioned(
                            top: MediaQuery.of(context).padding.top,
                            width: MediaQuery.of(context).size.width - 80,
                            child: Row(
                              children: [
                                CupertinoButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (c) => CupertinoAlertDialog(
                                              title: Text('确定是否退出'),
                                              actions: [
                                                CupertinoButton(
                                                    child: Text(
                                                      '取消',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                                CupertinoButton(
                                                    child: Text(
                                                      '确定',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                    onPressed: () {
                                                      closeLive();
                                                      if (_recording) {
                                                        print("停止推流");
                                                        _connection?.close();
                                                        setState(() {
                                                          _recording = false;
                                                          start = false;
                                                          classController.text =
                                                              "";
                                                        });
                                                      }
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                              ],
                                            ));
                                  },
                                  padding: EdgeInsets.zero,
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              ],
                            ))
                        : Container(),
                    Positioned(
                        top: MediaQuery.of(context).padding.top,
                        width: MediaQuery.of(context).size.width - 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CupertinoButton(
                              onPressed: () {
                                if (currentPosition == CameraPosition.front) {
                                  currentPosition = CameraPosition.back;
                                } else {
                                  currentPosition = CameraPosition.front;
                                }
                                _stream?.attachVideo(
                                    VideoSource(position: currentPosition));
                              },
                              padding: EdgeInsets.zero,
                              child: const Icon(
                                Icons.flip_camera_android,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )),
                    start
                        ? Container()
                        : Positioned(
                            top: MediaQuery.of(context).size.height * 0.2,
                            width: 200,
                            height: 60,
                            child: CupertinoTextField.borderless(
                              controller: classController,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromRGBO(60, 63, 65, 0.5),
                              ),
                              placeholder: '输入课程主题',
                              placeholderStyle: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                    start
                        ? Container()
                        : Positioned(
                            bottom: MediaQuery.of(context).size.height * 0.2,
                            width: 200,
                            height: 60,
                            child: ElevatedButton(
                              child: Text('开始直播'),
                              onPressed: () async {
                                try {
                                  if (classController.text != "") {
                                    d.Dio dio = d.Dio();
                                    d.Response key = await dio.get(
                                        'http://101.200.120.36:8088/control/get',
                                        queryParameters: {
                                          'room': classController.text,
                                        });
                                    print('room key:' + key.data['data']);
                                    UserModel? myInfo = SpUtil.getObj(
                                        "user",
                                        (v) => UserModel.fromJson(
                                            v as Map<String, dynamic>));
                                    d.Response res = await dio.post(
                                        'http://121.40.208.79:10000/api/v1/live/room',
                                        data: {
                                          "room": {
                                            "roomName": classController.text,
                                            "roomKey": key.data['data'],
                                            "cover":
                                                covers[Random().nextInt(5)],
                                            "protocol": "rtmp",
                                            "ownerId": myInfo?.id,
                                            "ownerName": myInfo?.name,
                                            "ownerAvatar": myInfo?.photo,
                                            "open": "是",
                                            "beauty": 14,
                                            "location": "江苏南京",
                                            "type": "语文课",
                                            "limitNumber": "10",
                                            "comment": "是"
                                          },
                                          "users": ["1", "2", "3"]
                                        });
                                    print(res.data['data']['roomId']);
                                    roomId = res.data['data']['roomId'];
                                    if (res.data['success']) {
                                      if (!_recording) {
                                        print("开始推流");
                                        _connection?.connect(
                                            "rtmp://101.200.120.36:8086/live");
                                        print(classController.text);
                                        _stream?.publish(classController.text);
                                        setState(() {
                                          start = true;
                                        });
                                      }
                                    }
                                  } else {
                                    EasyLoading.showToast('请输入内容');
                                  }
                                } catch (e) {
                                  EasyLoading.showError('服务异常');
                                }
                              },
                            ))
                  ],
                ),
        ),
      ),
    );
  }
}
