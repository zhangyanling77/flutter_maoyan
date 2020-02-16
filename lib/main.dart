import 'package:flutter/material.dart';
import 'home/MyHomePage.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 项目的内容就需要写在 MaterialApp 的里面
    return MaterialApp(
      title: 'app',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      // 传入自定义的组件
      home: MyHomePage(),
    );
  }
}
