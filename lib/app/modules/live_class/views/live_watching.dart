import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:fijkplayer_skin/fijkplayer_skin.dart';
import 'package:fijkplayer_skin/schema.dart' show VideoSourceFormat;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wit_niit/app/modules/message/widget/avatar.dart';

import '../model/Room.dart';

/**
 * 拉流
 */
class LiveWatching extends StatefulWidget {
  const LiveWatching({Key? key}) : super(key: key);

  @override
  State<LiveWatching> createState() => _LiveWatchingState();
}

class _LiveWatchingState extends State<LiveWatching> {
  List<Room> roomList = [];
  int page = 0;
  int size = 10;

  @override
  void initState() {
    getList();
    super.initState();
  }

  getList() async {
    Dio dio = Dio();
    Response res = await dio.get('http://121.40.208.79:10000/api/v1/live/room',
        queryParameters: {'page': page, 'size': size});
    (res.data['data'] as List)
        .forEach((element) => roomList.add(Room.fromJson(element)));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text('正在直播'),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((c, i) {
            Room room = roomList[i];
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VideoDetailPage(
                          room: room,
                        )));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: MediaQuery.of(context).size.height - 200,
                      //超出部分，可裁剪
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: room.cover ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Avatar(url: room.ownerAvatar ?? '', radius: 30),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              room.roomName ?? '',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              room.ownerName ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }, childCount: roomList.length),
        ),
      ],
    ));
  }
}

class VideoDetailPage extends StatefulWidget {
  final Room room;

  const VideoDetailPage({Key? key, required this.room}) : super(key: key);

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  final FijkPlayer player = FijkPlayer();

  VideoSourceFormat? _videoSourceTabs;

  int _curTabIdx = 0;
  int _curActiveIdx = 0;

  ShowConfigAbs vCfg = PlayerShowConfig();

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    String roomKey = widget.room.roomKey ?? '';
    Map<String, List<Map<String, dynamic>>> videoList = {
      "video": [
        {
          "name": "马老师的直播间",
          "list": [
            {
              "url": "http://101.200.120.36:8087/live/" + roomKey + ".flv",
              "name": "马老师的直播间"
            },
          ]
        },
      ]
    };
    // 格式化json转对象
    _videoSourceTabs = VideoSourceFormat.fromJson(videoList);
    // 这句不能省，必须有
    speed = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FijkView(
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          // fit: FijkFit.contain,
          player: player,
          panelBuilder: (
            FijkPlayer player,
            FijkData data,
            BuildContext context,
            Size viewSize,
            Rect texturePos,
          ) {
            /// 使用自定义的布局
            /// 精简模式，可不传递onChangeVideo
            return CustomFijkPanel(
              player: player,
              viewSize: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height),
              texturePos: texturePos,
              pageContent: context,
              // 标题 当前页面顶部的标题部分
              playerTitle: widget.room.roomName ?? '',
              // 当前视频源tabIndex
              curTabIdx: _curTabIdx,
              // 当前视频源activeIndex
              curActiveIdx: _curActiveIdx,
              // 显示的配置
              showConfig: vCfg,
              // json格式化后的视频数据
              videoFormat: _videoSourceTabs,
            );
          },
        ),
      ],
    );
  }
}

class PlayerShowConfig implements ShowConfigAbs {
  @override
  bool drawerBtn = false;
  @override
  bool nextBtn = false;
  @override
  bool speedBtn = false;
  @override
  bool topBar = true;
  @override
  bool lockBtn = true;
  @override
  bool autoNext = false;
  @override
  bool bottomPro = false;
  @override
  bool stateAuto = true;
  @override
  bool isAutoPlay = true;
}
