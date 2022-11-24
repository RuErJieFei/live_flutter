import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wit_niit/app/data/base_style.dart';
import 'package:wit_niit/app/modules/contacts/controllers/contacts_controller.dart';

import '../model/type_model.dart';
import '../views/dept_view.dart';

class MessageRowBox extends StatelessWidget {
  final String imgUrl;
  final String title;
  final bool isUser;

  MessageRowBox(
      {Key? key,
      required this.imgUrl,
      required this.title,
      required this.isUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white54,
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (!isUser)
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  imgUrl,
                ),
                fit: BoxFit.cover,
              )),
            ),
          if (isUser)
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                image: NetworkImage(
                  imgUrl,
                ),
                fit: BoxFit.cover,
              )),
            ),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: BaseStyle.messageMiddleStyle,
            ),
          )
        ],
      ),
    );
  }
}
