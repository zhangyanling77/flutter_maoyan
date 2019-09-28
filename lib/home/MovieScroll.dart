import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// 引入假数据
import '../data/CustomData.dart';

class MovieScroll extends StatelessWidget {
  // 定义数组数据
  // 在 flutter中, 一切皆组件，每一个组件都是一个类
  // 类的调用需要用new关键词，但是new 也可以省略
  final List scrolllist = CustomData().scrolllist;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      // 在我们的数据长度不固定的时候，我们就需要ListView.builder 这个方法来进行对数组的遍历
      child: ListView.builder(
        // 遍历出来的每一个组件的排列是横向的
        scrollDirection: Axis.horizontal,
        // itemCount 数组遍历的次数
        itemCount: scrolllist.length,
        // itemBuilder 每一次数组遍历所执行的函数，这个函数的返回值是一个组件/控件/Widget
        // context 上下文，系统默认需要传递的， index 是遍历时的当前索引
        itemBuilder: (BuildContext context, int index) {
          return ScrollItem(item: scrolllist[index]);
        },
      ),
    );
  }
}

class ScrollItem extends StatelessWidget {
  // 传参 接受 每一个item项的数据,
  ScrollItem({Key key, @required this.item}) : super(key: key);
  final Map item;

  // 类的重写，dart语法中  '类名()' 可以用这种方式接受参数
  // 大括号包含的值表示传参，key 是系统默认要求传递的
  // super 代表父类，无名无参
  // @required 代表这个参数是必填项

  @override
  Widget build(BuildContext context) {
    // 从上到下排列的组件
    return Container(
      width: 137.5,
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Column(
        children: <Widget>[
          // 图片
          Container(
            child: Image(
              width: 127.5,
              height: 178.5,
              // 插值表达式
              image: NetworkImage('${item["img"]}'),
              fit: BoxFit.cover,
            ),
          ),

          // 电影名字
          Text('${item["name"]}'),

          // 电影的描述信息
          Text(
            '${item["dra"]}',
            // 文字溢出点点点
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              color: Colors.grey
            ),
          ),
        ],
      ),
    );
  }
}
