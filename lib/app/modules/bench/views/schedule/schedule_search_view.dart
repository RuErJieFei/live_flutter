//继承SearchDelegate
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wit_niit/app/modules/bench/views/schedule/schedule_detail_search_view.dart';

import '../../../../../main.dart';
import '../../model/schedule_model_release.dart';

class search extends SearchDelegate{
//数据内容
  final List list=[];
  final List scheduleList = [];
  final rege=[
    "推荐-1",
    "推荐-2"
  ];
   searchSchedule() async {
    var data = {"address":query,"username":query,"description":query};
    var res = await request.get("/schedule/searchSchedules",params: data);
    // print(query);
    // list.clear();
    // scheduleList.clear();
    // list.addAll(res);
    // scheduleList.addAll(list.map((e) => Data.fromJson(e)).toList());
    // query = "";
    // print(res);
    return res;
  }
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
    return FutureBuilder(
      future:  searchSchedule(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // 请求已结束
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // 请求失败，显示错误
            return Text("Error: ${snapshot.error}");
          } else {
            list.clear();
            scheduleList.clear();
            list.addAll(snapshot.data);
            scheduleList.addAll(list.map((e) => Data.fromJson(e)).toList());
            // 请求成功，显示数据
            return Container( //点击确认后会关闭搜索页面，并显示如下组件内容
                  width: 1.sw,
                  height: 1.sh,
                  child: ListView.builder(itemCount: scheduleList.length,itemBuilder: (context,index) {
                    var str  =  scheduleList[index].startTime.toString().substring(5,16);
                    return GestureDetector(onTap: (){
                      Get.to(()=>ScheduleDetailSearchView(scheduleList[index].scheduleId));
                    },child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 50.w,
                          child: Text(

                            str,

                          ),
                        ),
                        Container(
                          width: 2.h,
                          height: MediaQuery.of(context).size.width * 0.15.h,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        SizedBox(
                          height: 80.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(scheduleList[index].topic ??
                                  "(无主题)"),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(scheduleList[index].address ??
                                  ""),
                            ],
                          ),
                        )
                      ],


                    ));
                  }),
                );
          }
        } else {
          // 请求未结束，显示loading
          return CircularProgressIndicator();
        }
      },
    );
    // return Container( //点击确认后会关闭搜索页面，并显示如下组件内容
    //   width: 1.sw,
    //   height: 1.sh,
    //   child: ListView.builder(itemCount: scheduleList.length,itemBuilder: (context,index) {
    //     var str  =  scheduleList[index].startTime.toString().substring(5,16);
    //     return ListTile(leading:Text(str) ,);
    //   }),
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Container();
  }

  //重写输入过程方法,在输入过程不断调用
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//
//     //输入框内容为空，数据数组为rege，后面ListView.builder动态生成
//     //输入框不为空时,利用数组.where()过滤器,返回满足将输入内容作为开头的数组中的字符串,再toList方法转换成数组
//     // final sugList=query.isEmpty ? rege:list.where((input)=>input.startsWith(query)).toList();
// return Container();
//     //调用动态列表生成数据
//     // return ListView.builder(
//     //   itemCount: sugList.length,
//     //   itemBuilder: (context,index)=>ListTile(
//     //     //利用富文本组件,将字符串变成可以设置各个片段样式以及事件的字符串
//     //     title: RichText(
//     //       text: TextSpan(
//     //         //截取数组中已经输入的内容的长度的字符串,并修改其样式
//     //           text: sugList[index].substring(0,query.length),
//     //           style: TextStyle(
//     //               color: Colors.black,
//     //               fontWeight: FontWeight.w900
//     //           ),
//     //           children: [
//     //             TextSpan(
//     //               //截取数组中的每条字符串输入内容长度之后的字符，并修改其样式
//     //               text: sugList[index].substring(query.length),
//     //               style: TextStyle(color: Colors.grey),
//     //
//     //             )
//     //           ]
//     //       ),
//     //     ),
//     //   ),
//     // );
//   }
}
