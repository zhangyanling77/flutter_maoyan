import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// 引入无缝滚动组件 MovieScroll
import 'MovieScroll.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ListView 可以排列，不考虑溢出的
    // Column 是在一个盒子里上下放物品, 要考虑溢出
    return ListView(
      children: <Widget>[
        HomeBodyArea(title: '最新电影'),
        HomeBodyArea(title: '最新电视剧'),
        HomeBodyArea(title: '最新动漫'),
        HomeBodyArea(title: '最新综艺'),
      ],
    );
  }
}

// 我们的页面有4个区块，所以拆分出来
class HomeBodyArea extends StatelessWidget {
  HomeBodyArea({Key key, @required this.title}):super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Column 纵向排列组件, Row横向排列组件
      child: Column(
        // 排列
        // mainAxisAlignment:  指的是主轴
        // crossAxisAlignment: 指的是副轴/交叉轴
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Row(
              // 在主轴上进行排列, 让文字重新排版
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  // 插值表达式当中 只有一个变量那就不要用大括号
                  '$title',
                  style: TextStyle(fontSize: 18, height: 1.3),
                ),
                Text(
                  '更多>>',
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
          ),

          // 电影无缝滚动区域
          MovieScroll()
        ],
      ),
    );
  }
}
