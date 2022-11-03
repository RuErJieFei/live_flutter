import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

/// 图片全屏展示
class ImageShowServer extends StatefulWidget {
  const ImageShowServer({
    Key? key,
    required this.initialIndex,
    required this.photoList,
  }) : super(key: key);
  final int initialIndex;
  final List photoList;

  @override
  State<ImageShowServer> createState() => _ImageShowServerState();
}

class _ImageShowServerState extends State<ImageShowServer> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              onPageChanged: onPageChanged,
              itemCount: widget.photoList.length,
              pageController: PageController(
                initialPage: _currentIndex,
              ),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(widget.photoList[index].runtimeType == String
                      ? widget.photoList[index]
                      : widget.photoList[index].url),
                  minScale: PhotoViewComputedScale.contained * 0.6,
                  maxScale: PhotoViewComputedScale.covered * 1.1,
                  initialScale: PhotoViewComputedScale.contained,
                );
              },
            ),
          ),
          Positioned(
            left: 10,
            top: 60,
            child: GestureDetector(
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            right: 10,
            bottom: 60,
            child: Row(
              children: <Widget>[
                Text(
                  '${_currentIndex + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const Text(
                  '/',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  '${widget.photoList.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///图片切换
  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
