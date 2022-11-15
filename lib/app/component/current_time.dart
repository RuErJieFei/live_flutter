/// FileName current_time
///
/// @Author chenrongqi
/// @Date 2022/11/15 14:14
///
/// @Description 实时电子钟
import 'dart:async';

import 'package:flutter/material.dart';

const CLOCK_INTERVAL = Duration(microseconds: 1000);
const ChineseWeekDays = <int, String>{
  1: '一',
  2: '二',
  3: '三',
  4: '四',
  5: '五',
  6: '六',
  7: '日',
};

String pad0(int num) {
  if (num < 10) {
    return '0${num.toString()}';
  }
  return num.toString();
}

class ClockBaseStatefulWidget extends StatefulWidget {
  ClockBaseStatefulWidget({Key? key}) : super(key: key);

  @override
  ClockBaseState createState() {
    var state = new ClockBaseState();
    state.startClock();
    return state;
  }
}

class ClockBaseState<T extends StatefulWidget> extends State {
  ClockBaseState() : super();

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return new Text('ClockBaseState is not implemented!');
  }

  startClock() {
    Timer.periodic(CLOCK_INTERVAL, (Timer t) {
      if (!mounted) {
        return;
      }

      setState(() {
        now = DateTime.now();
      });
    });
  }

  Size getDeviceSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}

class TimerWidget extends StatefulWidget {
  late String name;
  late String title;

  @override
  State<StatefulWidget> createState() {
    var state = new _TimerWidgetState();
    state.startClock();
    return state;
  }
}

class _TimerWidgetState extends ClockBaseState<TimerWidget> {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(
          text:
              "${now.month}-${now.day} ${pad0(now.hour)}:${pad0(now.minute)}:${pad0(now.second)}",
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ]),
    );
  }
}
