import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'dart:ui';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';

class BaseExtend {
  /*
      验证List、Map、String是否有值
      @return （true：有值 false：空）
   */
  static isValue(var value) {
    if (value == null) return false;
    if (value is String && value.length != 0 && value.isNotEmpty) {
      return true;
    } else if (value is List && value.isNotEmpty && value.length > 0) {
      return true;
    } else if (value is Map && value.isNotEmpty) {
      return true;
    }
    return false;
  }

  ///List转String用逗号分隔
  static String getStringFromString(List object) {
    if (BaseExtend.isValue(object)) {
      // List tempList = List();
      String str = '';

      str = object.join(",");

      // object.forEach((f) {
      //   tempList.add(f);
      // });

      // tempList.forEach((f) {
      //   if (str == '') {
      //     str = "$f";
      //   } else {
      //     str = "$str" "," "$f";
      //   }
      // });

      return str;
    }
    return '';
  }

  ///String用逗号分隔转List
  static List getStringFromList(
    String object, {
    String separator = ',',
  }) {
    List list = [];
    if (BaseExtend.isValue(object)) {
      list = object.split(separator);
      return list;
    }
    return list;
  }

  ///获取随机颜色
  static Color getRandomColor() {
    int index = BaseExtend.getRandomNumber(4);
    switch (index) {
      case 0:
        {
          return const Color(0xFFFF0000);
        }
      case 1:
        {
          return const Color(0xFFFF7A00);
        }
      case 2:
        {
          return const Color(0xFF0066FF);
        }
      case 3:
        {
          return const Color(0xFF00FF57);
        }

      default:
    }
    return Color.fromARGB(
      255,
      Random.secure().nextInt(200),
      Random.secure().nextInt(200),
      Random.secure().nextInt(200),
    );
  }

  ///获取随机数
  static int getRandomNumber(int index) {
    return Random().nextInt(index);
  }

  ///时间戳转DateTime
  static DateTime safeDateFromMillisecond(int value) {
    String time = value.toString();

    if (time.length <= 10) {
      time = time + '000';
    }
    return DateTime.fromMillisecondsSinceEpoch(int.parse(time));
  }

  ///时间转字符串
  static String safeStringFromDate(DateTime date, String format) {
    String timeStr = '';

    timeStr = DateFormat(format).format(date);

    return timeStr;
  }

  ///手机加密
  static String setEncryptWithPhone(String phone) {
    String str = '';
    if (phone.length >= 11) {
      str = phone.replaceFirst(RegExp(r'\d{4}'), '****', 3);
    }
    return str;
  }

  ///传入时间年月是否小于等于当前年月 type 0 表示日 1表示月 2表示年
  static bool compareCurrentTime(String value, int type) {
    bool isLess = false;
    DateTime nowDate = DateTime.now();

    int year2 = int.parse(safeStringFromDate(nowDate, 'yyyy'));

    int month2 = int.parse(safeStringFromDate(nowDate, 'MM'));

    int day2 = int.parse(safeStringFromDate(nowDate, 'dd'));

    if (type == 0) {
      value = value.replaceAll('年', '-');
      value = value.replaceAll('月', '-');
      value = value.replaceAll('日', '');

      DateTime currentDate = DateTime.parse(value);

      int year1 = int.parse(safeStringFromDate(currentDate, 'yyyy'));

      int month1 = int.parse(safeStringFromDate(currentDate, 'MM'));

      int day1 = int.parse(safeStringFromDate(currentDate, 'dd'));

      if (year1 < year2) {
        isLess = true;
      } else if (year1 == year2) {
        if (month1 < month2) {
          isLess = true;
        } else if (month1 > month2) {
          isLess = false;
        } else if (month1 == month2) {
          if (day1 < day2) {
            isLess = true;
          }
        }
      }
    } else if (type == 1) {
      value = value.replaceAll('年', '-');
      value = value.replaceAll('月', '-');
      value = value + '01';

      DateTime currentDate = DateTime.parse(value);

      int year1 = int.parse(safeStringFromDate(currentDate, 'yyyy'));

      int month1 = int.parse(safeStringFromDate(currentDate, 'MM'));

      if (year1 < year2) {
        isLess = true;
      } else if (year1 == year2) {
        if (month1 < month2) {
          isLess = true;
        }
      }
    } else if (type == 2) {
      value = value.replaceAll('年', '');

      int year1 = int.parse(value);

      if (year1 < year2) {
        isLess = true;
      }
    }

    return isLess;
  }

  ///获取某个月的天数
  static int daysInMonth(year, month) {
    return DateTime(year, month + 1, 0).day;
  }

  ///MD5加密
  static String generateMD5(String value) {
    var content = new Utf8Encoder().convert(value);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  ///获取cookie
  static String getCookie(Map cookieMap) {
    List list = [];
    String cookie = '';
    if (BaseExtend.isValue(cookieMap['set-cookie'])) {
      List cookieList = cookieMap['set-cookie'] as List;
      if (cookieList.length > 0) {
        String str = cookieList[0] as String;
        if (BaseExtend.isValue(str)) {
          list = str.split(';');
          if (list.length > 0) {
            cookie = list[0];
          }
        }
      }
    }
    return cookie;
  }

  ///返回开始/结束时间
  static List backStartAndEndTime(DateTime date, int type) {
    List list = [];
    String endTime = '';
    String startTime = '';

    int year = int.parse(
      BaseExtend.safeStringFromDate(date, 'yyyy'),
    );
    int month = int.parse(
      BaseExtend.safeStringFromDate(date, 'MM'),
    );
    int day = int.parse(
      BaseExtend.safeStringFromDate(date, 'dd'),
    );
    if (type == 0) {
      DateTime startDate = DateTime(
        year,
        month,
        day,
        0,
        0,
        0,
      );
      DateTime endDate = DateTime(
        year,
        month,
        day,
        23,
        59,
        59,
      );
      startTime = startDate.millisecondsSinceEpoch.toString();
      endTime = endDate.millisecondsSinceEpoch.toString();
    } else if (type == 1) {
      DateTime startDate = DateTime(
        year,
        month,
        1,
        0,
        0,
        0,
      );
      DateTime endDate = DateTime(
        year,
        month,
        daysInMonth(year, month),
        23,
        59,
        59,
      );
      startTime = startDate.millisecondsSinceEpoch.toString();
      endTime = endDate.millisecondsSinceEpoch.toString();
    } else if (type == 2) {
      DateTime startDate = DateTime(
        year,
        1,
        1,
        0,
        0,
        1,
      );
      DateTime endDate = DateTime(
        year,
        12,
        31,
        23,
        59,
        59,
      );
      startTime = startDate.millisecondsSinceEpoch.toString();
      endTime = endDate.millisecondsSinceEpoch.toString();
    }
    list.add(startTime);
    list.add(endTime);

    return list;
  }

  ///有传入时间返回一年的开始和结束时间
  static List backYearStartAndEndTime(DateTime date) {
    List list = [];
    String endTime = '';
    String startTime = '';

    int year = int.parse(
      BaseExtend.safeStringFromDate(date, 'yyyy'),
    );
    DateTime startDate = DateTime(
      year,
      01,
      01,
      0,
      0,
      0,
    );
    DateTime endDate = DateTime(
      year,
      12,
      31,
      23,
      59,
      59,
    );
    startTime = startDate.millisecondsSinceEpoch.toString();
    endTime = endDate.millisecondsSinceEpoch.toString();
    list.add(startTime);
    list.add(endTime);

    return list;
  }

  ///获取指定颜色
  static Color getSpecifyColor(int index) {
    Color color = getRandomColor();
    if (index == 0) {
      color = Color(0xFFF0AB43);
    } else if (index == 1) {
      color = Color(0xFFFFF461);
    } else if (index == 2) {
      color = Color(0xFF95F082);
    } else if (index == 3) {
      color = Color(0xFFF95050);
    } else if (index == 4) {
      color = Color(0xFFFFA59A);
    } else if (index == 5) {
      color = Color(0xFFF48DD8);
    } else if (index == 6) {
      color = Color(0xFFBBFFAD);
    } else if (index == 7) {
      color = Color(0xFFF1E550);
    } else if (index == 8) {
      color = Color(0xFFDB5567);
    } else if (index == 9) {
      color = Color(0xFFFD2DD0);
    }
    return color;
  }

  ///获取一个数最接近的整数
  static int calcuateNumber(double number) {
    int index = number.ceil();

    int a = index % 100;
    if (a > 0) {
      return (index ~/ 100) * 100 + 100;
    }

    return index;
  }

  ///value 数值 unit 单位 isElectricity是否是电量
  static String getDealNumwithstring(String value, String unit) {
    String str = '';
    if (value == '--') {
      return value;
    }
    double valueNum = double.parse(value);
    double number = 0;
    if (unit.contains('W·h')) {
      if (valueNum > 1000000) {
        number = valueNum / 1000000;
        str = number.toStringAsFixed(2) + ' ';
      } else if (valueNum > 1000) {
        number = valueNum / 1000;
        str = number.toStringAsFixed(2) + ' ';
      } else {
        str = valueNum.toString() + ' ';
      }
    } else {
      if (valueNum > 10000) {
        number = valueNum / 10000;
        str = number.toStringAsFixed(2) + ' ';
      } else {
        str = valueNum.toString() + ' ';
      }
    }
    return str;
  }

  ///value 数值 unit 单位 isElectricity是否是电量
  static String getDealUnitstring(String value, String unit) {
    if (value == '--') {
      return value;
    }
    double valueNum = double.parse(value);

    if (unit.contains('W·h')) {
      if (valueNum > 1000000) {
        return 'G' + 'W·h';
      } else if (valueNum > 1000) {
        return 'M' + 'W·h';
      } else {
        return unit;
      }
    } else {
      if (valueNum > 10000) {
        return '万' + unit;
      } else {
        return unit;
      }
    }
  }

  ///
  static String getDealNumwithstring1(String value, String unit) {
    String str = '';
    if (value == '--') {
      return value;
    }
    double valueNum = double.parse(value);
    double number = 0;
    if (unit.contains('W·h')) {
      number = valueNum / 1000;
      str = number.toStringAsFixed(2) + ' ';
    } else {
      number = valueNum / 10000;
      str = number.toStringAsFixed(2) + ' ';
    }
    return str;
  }

  ///
  static String getDealUnitstring1(String value, String unit) {
    if (value == '--') {
      return value;
    }

    if (unit.contains('W·h')) {
      return 'M' + 'W·h';
    } else {
      return '万' + unit;
    }
  }

  ///秒转分：秒
  static String secondsToMinutesOrHours(int value) {
    String time = '';
    if (value < 60) {
      if (value < 10) {
        time = '00:0$value';
      } else {
        time = '00:$value';
      }
    }
    if (60 <= value) {
      int seconds = 0;
      int minutes = 0;
      if (value == 60) {
        minutes = 1;
      } else {
        minutes = value ~/ 60;
        seconds = value % 60;
      }

      if (minutes < 10) {
        if (seconds < 10) {
          time = '0$minutes:0$seconds';
        } else {
          time = '0$minutes:$seconds';
        }
      } else {
        if (seconds < 10) {
          time = '$minutes:0$seconds';
        } else {
          time = '$minutes:$seconds';
        }
      }
    }
    return time;
  }
}
