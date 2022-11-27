import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        child: TextField(
          onChanged: (value) {},
          decoration: InputDecoration(
              hintText: '搜索',
              prefixIcon: Material(
                  elevation: 0,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  child: Icon(
                    Icons.search,
                  )),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12.0)),
        ),
      ),
    );
  }
}
