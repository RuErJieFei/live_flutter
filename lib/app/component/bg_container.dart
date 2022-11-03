import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wit_niit/app/data/base_data.dart';

/// 有状态背景
class BGContainer extends StatefulWidget {
  /// 背景颜色
  final Color bgColor;

  final Widget? child;

  ///宽度
  final double cWidth;

  ///高度
  final double cHeight;

  ///点击回调
  final clickCallBack;

  ///缺省页 0不用管 1加载中 2 暂无数据 3网络加载失败
  final int defaultType;

  BGContainer({
    this.bgColor = BaseData.kBackColor,
    this.child,
    this.cWidth = 0,
    this.cHeight = 0,
    this.defaultType = 0,
    this.clickCallBack,
  });

  @override
  _BGContainerState createState() => _BGContainerState();
}

class _BGContainerState extends State<BGContainer> {
  @override
  Widget build(BuildContext context) {
    String bgStr = '';
    String contextStr = '';
    if (widget.defaultType == 1) {
      bgStr = 'images/public/icon_loading.png';
      contextStr = '加载中';
    } else if (widget.defaultType == 2) {
      bgStr = 'images/public/icon_no_data.png';
      contextStr = '暂无数据';
    } else if (widget.defaultType == 3) {
      bgStr = 'images/public/icon_no_network.png';
      contextStr = '暂无信号';
    }
    final mediaQuery = MediaQuery.of(context).size;
    return Container(
      width: (widget.cWidth == 0) ? mediaQuery.width : widget.cWidth,
      height: (widget.cHeight == 0) ? mediaQuery.height : widget.cHeight,
      color: widget.bgColor,
      alignment: (widget.defaultType != 0) ? Alignment.center : Alignment.topLeft,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode()); // 关闭键盘
        },
        child: (widget.defaultType != 0)
            ? InkWell(
                onTap: () {
                  if (widget.defaultType != 1) {
                    widget.clickCallBack(widget.defaultType);
                  }
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(bgStr),
                      Container(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Text(
                          contextStr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : widget.child,
      ),
    );
  }
}
