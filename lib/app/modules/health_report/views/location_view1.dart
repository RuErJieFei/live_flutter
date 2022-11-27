// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
//     show
//         BMFCoordinate,
//         BMFEdgeInsets,
//         BMFLog,
//         BMFMapSDK,
//         BMFPoint,
//         BMF_COORD_TYPE;
// import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
// import 'package:flutter_bmflocation/flutter_bmflocation.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class LocationView extends StatefulWidget {
//   @override
//   _LocationPageState createState() => _LocationPageState();
// }
//
// class _LocationPageState extends State<LocationView> {
//   BMFMapController? myMapController;
//
//   late LocationFlutterPlugin _locationPlugin;
//
//   BMFMapOptions _BMFMapOptions = BMFMapOptions(
//       center: BMFCoordinate(39.917215, 116.380341),
//       zoomLevel: 12,
//       mapPadding: BMFEdgeInsets(left: 30, top: 0, right: 30, bottom: 0));
//
//   BaiduLocationIOSOption iosOption =
//       BaiduLocationIOSOption(coordType: BMFLocationCoordType.gcj02);
//
//   BaiduLocationAndroidOption androidOption =
//       BaiduLocationAndroidOption(coordType: BMFLocationCoordType.gcj02);
//
//   late BMFMapController _controller;
//
//   late BaiduLocation _location;
//
//   @override
//   void initState() {
//     super.initState();
//
//     /// 动态申请定位权限
//     requestPermission();
//
//     /// 动态监听地图信息
//     // _locationPlugin.seriesLocationCallback(callback: (BaiduLocation result) {
//     //   setState(() {
//     //     print('更新了状态');
//     //     if (result != null) {
//     //       _locationResult = result;
//     //     }
//     //   });
//     // });
//
//     _locationPlugin = LocationFlutterPlugin();
//     _locationPlugin.setAgreePrivacy(true);
//     _location = BaiduLocation();
//     _locationPlugin.seriesLocationCallback(callback: (BaiduLocation result) {
//       _location = result;
//       _stopLocation();
//       updatePosition();
//     });
//
//     _startLocation();
//   }
//
//   /// 设置android端和ios端定位参数
//   void _setLocOption1() {
//     /// android 端设置定位参数
//     BaiduLocationAndroidOption initAndroidOptions() {
//       BaiduLocationAndroidOption options = BaiduLocationAndroidOption(
//           // 定位模式，可选的模式有高精度、仅设备、仅网络。默
//           //       认为高精度模式
//           locationMode: BMFLocationMode.hightAccuracy,
//           // 是否需要返回地址信息
//           isNeedAddress: true,
//           // 是否需要返回海拔高度信息
//           isNeedAltitude: true,
//           // 是否需要返回周边poi信息
//           isNeedLocationPoiList: true,
//           // 是否需要返回新版本rgc信息
//           isNeedNewVersionRgc: true,
//           // 是否需要返回位置描述信息
//           isNeedLocationDescribe: true,
//           // 是否使用gps
//           openGps: true,
//           // 可选，设置场景定位参数，包括签到场景、运动场景、出行场景
//           locationPurpose: BMFLocationPurpose.sport,
//           // 坐标系
//           coordType: BMFLocationCoordType.bd09ll,
//           // 设置发起定位请求的间隔，int类型，单位ms
//           // 如果设置为0，则代表单次定位，即仅定位一次，默认为0
//           scanspan: 0);
//       return options;
//     }
//
//     BaiduLocationIOSOption initIOSOptions() {
//       BaiduLocationIOSOption options = BaiduLocationIOSOption(
//         // 坐标系
//         coordType: BMFLocationCoordType.bd09ll,
//         // 位置获取超时时间
//         locationTimeout: 10,
//         // 获取地址信息超时时间
//         reGeocodeTimeout: 10,
//         // 应用位置类型 默认为automotiveNavigation
//         activityType: BMFActivityType.automotiveNavigation,
//         // 设置预期精度参数 默认为best
//         desiredAccuracy: BMFDesiredAccuracy.best,
//         // 是否需要最新版本rgc数据
//         isNeedNewVersionRgc: true,
//         // 指定定位是否会被系统自动暂停
//         pausesLocationUpdatesAutomatically: false,
//         // 指定是否允许后台定位,
//         // 允许的话是可以进行后台定位的，但需要项目
//         // 配置允许后台定位，否则会报错，具体参考开发文档
//         allowsBackgroundLocationUpdates: true,
//         // 设定定位的最小更新距离
//         distanceFilter: 10,
//       );
//       return options;
//     }
//
//     Map androidMap = initAndroidOptions().getMap();
//     Map iosMap = initIOSOptions().getMap();
//     _locationPlugin.prepareLoc(androidMap, iosMap);
//   }
//
//   /// 停止定位
//   void _stopLocation() {
//     if (null != _locationPlugin) {
//       _locationPlugin.stopLocation();
//     }
//   }
//
//   //  申请权限
//   Future<bool> requestPermission() async {
//     // 申请权限
//     final status = await Permission.location.request();
//     //获取存储权限，可能涉及到地图的shareprefences读写问题，建议加上并进行判断
//     //await Permission.storage.status;
//
//     if (status.isGranted) {
//       print("定位权限申请通过");
//       return true;
//     } else {
//       print("定位权限申请不通过");
//       return false;
//     }
//   }
//
// //  开始定位
//   void _startLocation() {
//     if (null != _locationPlugin) {
//       //申请定位权限
//       requestPermission().then((value) => {
//             if (value)
//               {_setLocOption(), _locationPlugin.startLocation()}
//             else
//               {print('需要申请定位权限')}
//           });
//     }
//   }
//
// //  设置定位参数
//   void _setLocOption() {
//     androidOption.setCoorType("bd09ll"); // 设置返回的位置坐标系类型
//     androidOption.setIsNeedAltitude(true); // 设置是否需要返回海拔高度信息
//     androidOption.setIsNeedAddress(true); // 设置是否需要返回地址信息
//     androidOption.setIsNeedLocationPoiList(true); // 设置是否需要返回周边poi信息
//     androidOption.setIsNeedNewVersionRgc(true); // 设置是否需要返回最新版本rgc信息
//     androidOption.setIsNeedLocationDescribe(true); // 设置是否需要返回位置描述
//     androidOption.setOpenGps(true); // 设置是否需要使用gps
//     androidOption.setLocationMode(BMFLocationMode.hightAccuracy); // 设置定位模式
//     androidOption.setScanspan(1000); // 设置发起定位请求时间间隔
//     Map androidMap = androidOption.getMap();
//     Map iosdMap = iosOption.getMap();
//     _locationPlugin.prepareLoc(androidMap, iosdMap); //ios和安卓定位设置
//   }
//
// //更新地点
//   void updatePosition() {
//     BMFCoordinate coordinate = BMFCoordinate(
//         _location.latitude ?? 39.917215, _location.longitude ?? 116.380341);
//
//     BMFMapOptions options = BMFMapOptions(
//         center: coordinate,
//         zoomLevel: 17,
//         mapPadding: BMFEdgeInsets(left: 30, top: 0, right: 30, bottom: 0));
//
//     BMFLocation location = BMFLocation(
//         coordinate: coordinate,
//         altitude: 0,
//         horizontalAccuracy: 5,
//         verticalAccuracy: -1.0,
//         speed: -1.0,
//         course: -1.0);
//
//     BMFUserLocation userLocation = BMFUserLocation(
//       location: location,
//     );
//
//     _controller.updateLocationData(userLocation);
//     _controller.updateMapOptions(options);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("选取定位"),
//       ),
//       body: Column(
//         children: [
//           Container(
//             width: screenSize.width,
//             height: screenSize.height / 2,
//             child: BMFMapWidget(
//               onBMFMapCreated: (controller) {
//                 onBMFMapCreated(controller);
//               },
//               mapOptions: _BMFMapOptions,
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               myMapController?.showUserLocation(true);
//               BMFCoordinate coordinate = BMFCoordinate(39.965, 116.404);
//
//               BMFLocation location = BMFLocation(
//                   coordinate: coordinate,
//                   altitude: 0,
//                   horizontalAccuracy: 5,
//                   verticalAccuracy: -1.0,
//                   speed: -1.0,
//                   course: -1.0);
//
//               BMFUserLocation userLocation = BMFUserLocation(
//                 location: location,
//               );
//
//               myMapController?.updateLocationData(userLocation);
//
//               BMFUserLocationDisplayParam displayParam =
//                   BMFUserLocationDisplayParam(
//                       locationViewOffsetX: 0,
//                       locationViewOffsetY: 0,
//                       accuracyCircleFillColor: Colors.red,
//                       accuracyCircleStrokeColor: Colors.blue,
//                       isAccuracyCircleShow: true,
//                       locationViewImage: 'images/school/location.png',
//                       locationViewHierarchy: BMFLocationViewHierarchy
//                           .LOCATION_VIEW_HIERARCHY_BOTTOM);
//
//               myMapController?.updateLocationViewWithParam(displayParam);
//               // _locationPlugin.seriesLocationCallback(
//               //     callback: (BaiduLocation result) {
//               //   //result为定位结果
//               //   print(result);
//               // });
//               // _startLocation();
//             },
//             child: Text('定位'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void onBMFMapCreated(BMFMapController controller) {
//     myMapController = controller;
//     myMapController?.showUserLocation(true);
//
//     /// 地图加载回调
//     myMapController?.setMapDidLoadCallback(callback: () {
//       print('mapDidLoad-地图加载完成!!!');
//     });
//   }
// }
