class NetUrl {
  ///本地地址
  // static const String kHttp_HostName = 'http://192.168.50.241:8080/niit-api';

  ///正式 (网关地址)
  static const String kHttp_HostName = "http://121.40.208.79:10000/api/v1";

  /// WebSocket
  static const String socket_HostName = "ws://121.40.208.79:8083/websocket/";

  /// 消息模块api
  static const String msg_HostName = "http://121.40.208.79:8083";

  /// 账户模块api
  static const String user_HostName = "http://121.40.208.79:8082";

  /// 通讯录模块api
  static const String message_HostName = "http://121.40.208.79:8081";

  /// 校园网卷模块api
  static const String survey_HostName = "http://121.40.208.79:8085";

  /// 日程模块api
  static const String schedule_HostName = "http://121.40.208.79:9010";

  ///账户登录
  static const String user_login = '/user/login';

  /// 获取验证码
  static const String user_vCode = '/user/vCode';
}
