//继承SearchDelegate
import 'package:flutter/material.dart';

class search extends SearchDelegate{
//数据内容
  final List list=[
    "jjjj-2dawd",
    "jjj222-awdwd",
    "jj333-cccaw",
    'gg-vva',
    "gg22-bdfaw",
    "gg333-lajd"
  ];
  final rege=[
    "推荐-1",
    "推荐-2"
  ];

  //重写搜索框右上角方法
  @override
  List<Widget> buildActions(BuildContext context){
    return [
      //放置按钮，点击时，将搜索框清空
      IconButton(
        icon:Icon(Icons.clear),
        onPressed: (){
          query="";
        },
      )
    ];
  }

  //重写左上角方法
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton( //返回动态按钮
      icon:AnimatedIcon(
        icon:AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){ //回调中调用close方法，关闭搜索页面
        close(context, null);
      },
    );
  }
//重写键盘点击确认后方法
  @override
  Widget buildResults(BuildContext context){
    return Container( //点击确认后会关闭搜索页面，并显示如下组件内容
      width: 100,
      height: 100,
      child: Card(
        color: Colors.brown,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  //重写输入过程方法,在输入过程不断调用
  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    //输入框内容为空，数据数组为rege，后面ListView.builder动态生成
    //输入框不为空时,利用数组.where()过滤器,返回满足将输入内容作为开头的数组中的字符串,再toList方法转换成数组
    final sugList=query.isEmpty ? rege:list.where((input)=>input.startsWith(query)).toList();

    //调用动态列表生成数据
    return ListView.builder(
      itemCount: sugList.length,
      itemBuilder: (context,index)=>ListTile(
        //利用富文本组件,将字符串变成可以设置各个片段样式以及事件的字符串
        title: RichText(
          text: TextSpan(
            //截取数组中已经输入的内容的长度的字符串,并修改其样式
              text: sugList[index].substring(0,query.length),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900
              ),
              children: [
                TextSpan(
                  //截取数组中的每条字符串输入内容长度之后的字符，并修改其样式
                  text: sugList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),

                )
              ]
          ),
        ),
      ),
    );
  }
}
