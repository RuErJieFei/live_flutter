import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:wit_niit/app/data/base_data.dart';

class BGPositionImage {
  ///占位图
  static positionImage(String imageUrl, {String positionImage = BaseData.kImage}) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) {
        LogUtil.v('占位===');
        return Image.asset(
          positionImage,
          fit: BoxFit.cover,
        );
      },
      errorWidget: (context, url, error) {
        LogUtil.v('报错');
        return Image.asset(
          positionImage,
          fit: BoxFit.cover,
        );
      },
      fit: BoxFit.cover,
    );
  }
}
