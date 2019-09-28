
// 引入 UI组件库
import 'package:flutter/material.dart';
// 引入 MyHomePage
import 'home/MyHomePage.dart';

// 定义入口函数
void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 我们的项目都需要写在 MaterialApp 的里面
    return MaterialApp(
      title: 'app',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      // 传入我们的自定义的 组件
      home: MyHomePage(),
    );
  }
}
