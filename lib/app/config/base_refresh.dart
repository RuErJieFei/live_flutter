import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 下拉刷新样式
class PullToRefreshStyle {
  /// 顶部样式
  header() {
    // return WaterDropHeader();
    return CustomHeader(
      builder: (context, mode) {
        return const SizedBox(
          height: 44.0,
          child: Center(
            child: CupertinoActivityIndicator(),
          ),
        );
      },
    );
  }

  /// 底部样式
  footer() {
    return CustomFooter(
      builder: (context, mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = const Text("no more");
        } else {
          body = const CupertinoActivityIndicator();
        }
        return SizedBox(
          height: 44.0,
          child: Center(child: body),
        );
      },
    );
  }
}
