# 智慧南工 Flutter 客户端

## 开发规范
- 建议少写 `StatefulWidget`
  在 `GetView` 或 `StatelessWidget` 里写 UI, 逻辑分离到 controller 里
  用 OBX 控制细粒度刷新

- 不用`print()`，在debug 模式输出日志 `LogUtil.v('>>>>>测试～～'); `

- 多人协作，都在命名路由里加路由，合并代码时候比较麻烦，优先使用正常路由跳转

  ```dart
  Get.to(LoginView());
  
  Get.to(Home(), binding: HomeBinding());
  
  ```

  



```tex
app
	-| compoent  # 公共组件
	-| config # 配置
	-| data # 数据
    -| modules # 
    	-| bench # 工作台
    		-| bindings # Bindings类, 详情点下面链接
    		-| controller # 控制器，逻辑代码写这里
    		-| views # 视图, UI 代码写这里
    		-| widget # 封装的控件
    	-| index # 底部导航
    	-| message # 消息
    	-| ......
    -| routes # 命名路由
    -| utils # 工具类
    	-| request # 网络请求封装
    
```

- [Bindings类](https://github.com/jonataslaw/getx/blob/master/documentation/zh_CN/dependency_management.md#bindings) 自动注入和移除控制器

- controller

  ```dart
  class ContactsController extends GetxController {
    //TODO: Implement ContactsController
  
    final count = 0.obs;     # obs变量用 final 或 var 定义
    @overrid
    void onInit() {       # 相当于 stful 的  initState()
      super.onInit();
    }
  
    @override
    void onReady() {   # 在 onInit() 后立即运行
      super.onReady();
    }
  
    @override     
    void onClose() {    # 相当于 stful 的 dispose()
      super.onClose();
    }
  }
  ```

- view

  - GetView<Controller>

     App_pages.dart 路由数组里绑定了binding 就会自动注入

    

  ```dart
  class ContactsView extends GetView<ContactsController> {
    const ContactsView({Key? key}) : super(key: key);
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ContactsView'),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            'ContactsView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }
  }
  ```

  否则要手动注入，首次用 put ，子页面用 find

  ```dart
  var a = Get.put<HomeController>();
  
  var c = Get.find<HomeController>();
  ```

  - StelessWidget

    ```dart
    class HomeView extends StatelessWidget {
      HomeController controller = Get.put(HomeController());
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Obx(() {
              return Text('${controller.count}');
            }),
          ),
    ```

    

