import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/src/map/bmf_models.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/base_style.dart';
import '../../../data/school_theme_data.dart';

class LocationView extends StatefulWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MapRouteState();
  }
}

class MapRouteState extends State<LocationView> {
  late TextEditingController positionController;
  late LocationFlutterPlugin _locationPlugin;

  BaiduLocationIOSOption iosOption =
      BaiduLocationIOSOption(coordType: BMFLocationCoordType.gcj02);
  BaiduLocationAndroidOption androidOption =
      BaiduLocationAndroidOption(coordType: BMFLocationCoordType.gcj02);
  late BMFMapController _controller;
  late BaiduLocation _location;

  //周边信息
  List<BaiduPoiList> _poiList = [];

  @override
  void initState() {
    positionController = TextEditingController();
    _locationPlugin = LocationFlutterPlugin();
    _locationPlugin.setAgreePrivacy(true);
    _location = BaiduLocation();
    _locationPlugin.seriesLocationCallback(callback: (BaiduLocation result) {
      _location = result;
      _stopLocation();
      updatePosition();
    });
    _startLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "选取地点",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: SchoolConfig.primaryColor,
      ),
      body: _map(),
    );
  }

  Widget _map() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    '取消',
                    style: BaseStyle.schoolContentStyle,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.r),
                  padding: EdgeInsets.symmetric(horizontal: 10.r),
                  width: 300.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: Colors.grey.shade200,
                  ),
                  child: TextField(
                    controller: positionController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      icon: Icon(Icons.search),
                      border: InputBorder.none,
                      hintText: "搜索",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // serchPosition(positionController.text);
                    Get.back(result: {
                      'list': _poiList[0].toMap(),
                      'longitude': _location.longitude,
                      'latitude': _location.latitude
                    });
                  },
                  child: Text(
                    '确定',
                    style: BaseStyle.schoolContentStyle,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 300.h,
            child: BMFMapWidget(
              onBMFMapCreated: (controller) {
                //自定义onBMFMapCreated方法，用于获取controller
                onBMFMapCreated(controller);
              },
              mapOptions: BMFMapOptions(
                center: BMFCoordinate(39.917215, 116.380341),
                zoomLevel: 12,
                mapPadding:
                    BMFEdgeInsets(left: 30, top: 0, right: 30, bottom: 0),
              ),
            ),
          ),
          _poiList.length == 0
              ? Container()
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _poiList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Get.back(result: {
                          'list': _poiList[index].toMap(),
                          'longitude': _location.longitude,
                          'latitude': _location.latitude
                        });
                      },
                      child: ListTile(
                        title: Text(_poiList[index].name ?? ''),
                        subtitle: Text(_poiList[index].addr ?? ''),
                        trailing: index == 0
                            ? Icon(
                                Icons.check_circle,
                                color: SchoolConfig.primaryColor,
                              )
                            : Icon(
                                Icons.check_circle,
                              ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  void onBMFMapCreated(BMFMapController controller) {
    _controller = controller;
    _controller.showUserLocation(true);
  }

  //  申请权限
  Future<bool> requestPermission() async {
    // 申请权限
    final status = await Permission.location.request();
    if (status.isGranted) {
      print("定位权限申请通过");
      return true;
    } else {
      print("定位权限申请不通过");
      return false;
    }
  }

  /// 停止定位
  void _stopLocation() {
    if (null != _locationPlugin) {
      _locationPlugin.stopLocation();
    }
  }

  //  开始定位
  void _startLocation() {
    if (null != _locationPlugin) {
      //申请定位权限
      requestPermission().then((value) => {
            if (value)
              {_setLocOption(), _locationPlugin.startLocation()}
            else
              {
                EasyLoading.showToast("需要定位权限",
                    toastPosition: EasyLoadingToastPosition.bottom)
              }
          });
    }
  }

  //  设置定位参数
  void _setLocOption() {
    androidOption.setCoorType("bd09ll"); // 设置返回的位置坐标系类型
    androidOption.setIsNeedAltitude(true); // 设置是否需要返回海拔高度信息
    androidOption.setIsNeedAddress(true); // 设置是否需要返回地址信息
    androidOption.setIsNeedLocationPoiList(true); // 设置是否需要返回周边poi信息
    androidOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
    androidOption.setIsNeedLocationDescribe(true); // 设置是否需要返回位置描述
    androidOption.setOpenGps(true); // 设置是否需要使用gps
    androidOption.setLocationMode(BMFLocationMode.hightAccuracy); // 设置定位模式
    androidOption.setScanspan(1000); // 设置发起定位请求时间间隔
    Map androidMap = androidOption.getMap();
    Map iosdMap = iosOption.getMap();
    _locationPlugin.prepareLoc(androidMap, iosdMap); //ios和安卓定位设置
  }

  Future<void> serchPosition(String text) async {
    // 构造检索参数
    BMFSuggestionSearchOption suggestionSearchOption =
        BMFSuggestionSearchOption(
            keyword: text, cityname: _location.city ?? "北京");
    // 检索实例
    BMFSuggestionSearch suggestionSearch = BMFSuggestionSearch();
    // 检索回调
    suggestionSearch.onGetSuggestSearchResult(callback:
        (BMFSuggestionSearchResult result, BMFSearchErrorCode errorCode) {
      print('sug检索回调 result = ${result.toMap()} \n errorCode = ${errorCode}');
      // 解析reslut，具体参考demo
    });
    // 发起检索
    bool flag = await suggestionSearch.suggestionSearch(suggestionSearchOption);
  }

  void updatePosition() {
    BMFCoordinate coordinate = BMFCoordinate(
        _location.latitude ?? 39.917215, _location.longitude ?? 116.380341);

    BMFMapOptions options = BMFMapOptions(
        center: coordinate,
        zoomLevel: 17,
        mapPadding: BMFEdgeInsets(left: 30, top: 0, right: 30, bottom: 0));

    BMFLocation location = BMFLocation(
        coordinate: coordinate,
        altitude: 0,
        horizontalAccuracy: 5,
        verticalAccuracy: -1.0,
        speed: -1.0,
        course: -1.0);

    BMFUserLocation userLocation = BMFUserLocation(
      location: location,
    );

    setState(() {
      _poiList = _location.pois!;
    });
    _controller.updateLocationData(userLocation);
    _controller.updateMapOptions(options);
  }
}
