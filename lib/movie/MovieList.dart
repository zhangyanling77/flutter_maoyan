import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// 引入假数据
// import '../data/CustomData.dart';

// 引入dio插件，然后进行数据请求
import 'package:dio/dio.dart';
// 数据解析
import 'dart:convert';

// 引入详情页
import '../detail/Detail.dart';

// 动态组件
class MovieList extends StatefulWidget {
  // 每一个动态组件当中都需要一个createState函数
  // 返回值是 _MovieListState() 执行后的结果
  @override
  _MovieListState createState() => _MovieListState();
}

// 控制器，我们的动态组件的状态在里面被管理，而且这个控制器可以渲染被控制组件的UI结构
class _MovieListState extends State<MovieList> {
  // final List list = new CustomData().list;
  List list = [];

  @override
  // 状态初始化，系统提供的函数
  void initState() {
    getMovieList();
    super.initState();
  }

  // 请求数据
  getMovieList() async {
    try {
      // 生成一个dio实例
      Dio dio = Dio();
      // 调用get方法请求数据， 要使用 async await 来异步获取数据
      Response response = await dio.get(
          'http://m.maoyan.com/ajax/moreComingList?token=&movieIds=1178432%2C1205290%2C1298696%2C1260354%2C1203775%2C1215786%2C1263074%2C1223430%2C1219314%2C1170287');
      // 讲字符串类型的数据解析成Map对象
      Map responseData = jsonDecode(response.toString());

      // 把请求回来的数据 赋值给变量 list, 需要调用setState方法，否则页面不会刷新
      setState(() {
        list = responseData["coming"];
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 对传递的数组数据进行遍历
    return ListView.builder(
      // 遍历的数组长度
      itemCount: list.length,
      // 每次遍历执行的回调函数， 返回值是一个Widget
      itemBuilder: (BuildContext context, int i) {
        Map _myitem = list[i];
        // 如果你想给一个组件添加事件，那么就把它包裹在 GestureDetector 的内部,
        // GestureDetector 提供了很多事件供你调用
        return GestureDetector(
          onTap: (){
            // 跳转到 详情页
            // 这是系统为我们提供的路由跳转的方法 
            // MaterialPageRoute是 material U库提供的路由组件
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context){
                return Detail(id: _myitem["id"], nm: _myitem["nm"]);
              }
            ));
          },
          child: Container(
            // all 是四个方向的边距
            // fromLTRB 四个方向分别写 左上右下
            // only 是 left right top bottom 自己传参
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                // 左边图片
                Container(
                  width: 128,
                  height: 179,
                  child: Image(
                    image: NetworkImage('${_imgReset(_myitem["img"])}'),
                  ),
                ),

                // 右边部分文字区域
                // Expanded 弹性盒子容器，可以占据多余空间, 自动根据父容器的宽度来填充
                Expanded(
                  child: Container(
                    height: 160,
                    // color: Colors.yellow,
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      // 主轴和副轴对齐， 主轴均匀分布, 副轴居左
                      // 在竖直的方向上均匀分布
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // 在水平方向上 居左对齐
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${_myitem["nm"]}',
                          style: TextStyle(fontSize: 17),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          '评分: ${_myitem["sc"] ?? "无"}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          // ?? 这个用法来自于dart，是非空判断 前者有值用前者，前者没值用后者
                          '主演: ${_myitem["star"] ?? "无"}',
                          // overflow: TextOverflow.ellipsis,
                          // maxLines: 2,
                        ),
                        Text(
                          '上映日期: ${_myitem["comingTitle"] ?? "无"}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          '排期: ${_myitem["showInfo"] ?? "无"}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _imgReset(String img) => img.replaceAll('/w.h/', '/128.180/');
}
