import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate, BMFEdgeInsets, BMFLog, BMFMapSDK, BMF_COORD_TYPE;
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationController extends GetxController {
  final GeofenceFlutterPlugin _myGeofencePlugin = GeofenceFlutterPlugin();
  final LocationFlutterPlugin _myLocPlugin = LocationFlutterPlugin();

  @override
  void onInit() async {
    /// 动态申请定位权限
    requestPermission();

    /// 设置是否隐私政策
    /// 隐私政策官网链接：https://lbsyun.baidu.com/index.php?title=openprivacy
    /// 通知用户之后根据用户选择进行赋值
    _myLocPlugin.setAgreePrivacy(true);
    BMFMapSDK.setAgreePrivacy(true);

    // getLocation();
  }

  void _setUpLocation() {
    BaiduLocationAndroidOption initAndroidOptions() {
      BaiduLocationAndroidOption options = BaiduLocationAndroidOption(
          // 定位模式，可选的模式有高精度、仅设备、仅网络。默
          //       认为高精度模式
          locationMode: BMFLocationMode.hightAccuracy,
          // 是否需要返回地址信息
          isNeedAddress: true,
          // 是否需要返回海拔高度信息
          isNeedAltitude: true,
          // 是否需要返回周边poi信息
          isNeedLocationPoiList: true,
          // 是否需要返回新版本rgc信息
          isNeedNewVersionRgc: true,
          // 是否需要返回位置描述信息
          isNeedLocationDescribe: true,
          // 是否使用gps
          openGps: true,
          // 可选，设置场景定位参数，包括签到场景、运动场景、出行场景
          locationPurpose: BMFLocationPurpose.sport,
          // 坐标系
          coordType: BMFLocationCoordType.bd09ll,
          // 设置发起定位请求的间隔，int类型，单位ms
          // 如果设置为0，则代表单次定位，即仅定位一次，默认为0
          scanspan: 0);
      return options;
    }

    BaiduLocationIOSOption initIOSOptions() {
      BaiduLocationIOSOption options = BaiduLocationIOSOption(
        // 坐标系
        coordType: BMFLocationCoordType.bd09ll,
        // 位置获取超时时间
        locationTimeout: 10,
        // 获取地址信息超时时间
        reGeocodeTimeout: 10,
        // 应用位置类型 默认为automotiveNavigation
        activityType: BMFActivityType.automotiveNavigation,
        // 设置预期精度参数 默认为best
        desiredAccuracy: BMFDesiredAccuracy.best,
        // 是否需要最新版本rgc数据
        isNeedNewVersionRgc: true,
        // 指定定位是否会被系统自动暂停
        pausesLocationUpdatesAutomatically: false,
        // 指定是否允许后台定位,
        // 允许的话是可以进行后台定位的，但需要项目
        // 配置允许后台定位，否则会报错，具体参考开发文档
        allowsBackgroundLocationUpdates: true,
        // 设定定位的最小更新距离
        distanceFilter: 10,
      );
      return options;
    }

    Map androidMap = initAndroidOptions().getMap();
    Map iosMap = initIOSOptions().getMap();
    _myLocPlugin.prepareLoc(androidMap, iosMap);
  }

  //获取位置信息
  void getLocation() {
    // _myLocPlugin.onResultCallback(callback: (BaiduLocation result) {  }).listen(callback);
    _setUpLocation();
    _myLocPlugin.startLocation();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void map() {
    LocationCircleGeofenceOption option = LocationCircleGeofenceOption(
        // 半径,单位：米(必选)
        radius: '2000',
        // 围栏中心点（必选）
        centerCoordinate: BMFCoordinate(39.928617, 116.40329),
        // 坐标系
        coordType: BMFLocationCoordType.bd09ll,
        // 围栏监听通知类型
        activateAction: GeofenceActivateAction.geofenceAll,
        // 自定义围栏id
        customId: 'circleGeofence_id',
        // 定位是否会被系统自动暂停。(Andorid设置无效)
        pausesLocationUpdatesAutomatically: false,
        // 是否允许后台定位。(Andorid设置无效)
        allowsBackgroundLocationUpdates: true);

    //添加地理围栏
    _myGeofencePlugin.addCircleRegion(option.toMap());

    //地理围栏创建回调
    _myGeofencePlugin.geofenceFinishCallback(callback: (BMFGeofence? geofence) {
      if (geofence != null) {}
    });

    /**
     * 监听围栏状态发生改变时回调
     * geoFenceRegionStatus:
     * 1:进入围栏  2:围栏内停留超过10分钟  3:离开围栏
     */
    _myGeofencePlugin.didGeoFencesStatusChangedCallback(
        callback: (Map geofenceResult) {
      if (geofenceResult.isNotEmpty) {
        // setState(() {
        // Map map = geofenceResult['result'];
        // int status = map['geoFenceRegionStatus'] as int;
        // switch (status) {
        //   case 1:
        //     resultText = '进入地理围栏';
        //     break;
        //   case 2:
        //     resultText = '在围栏内停留超过10分钟';
        //     break;
        //   case 3:
        //     resultText = '在地理围栏之外';
        //     break;
        //   case 0:
        //     resultText = '定位失败';
        //     break;
        //   default:
        // }
        // });
      }
    });
  }

  // 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      // 权限申请通过
    } else {}
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
