import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wit_niit/app/data/base_style.dart';

class MessageRowBox extends StatelessWidget {
  final String imgUrl;
  final String title;

  MessageRowBox({Key? key, required this.imgUrl, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white54,
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: GestureDetector(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      imgUrl,
                    ),
                    fit: BoxFit.cover,
                  )),
            ),
            Text(
              title,
              style: BaseStyle.messageMiddleStyle,
            )
          ],
        ),
      )
    );
  }
}
