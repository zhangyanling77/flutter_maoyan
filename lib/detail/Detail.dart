import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

// 引入假数据
import '../data/CustomData.dart';

// 请求数据
import 'package:dio/dio.dart';
import 'dart:convert';

class Detail extends StatefulWidget {
  Detail({
    Key key,
    @required this.id,
    @required this.nm,
  }) : super(key: key);
  final int id;
  final String nm;

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  // 引入假数据
  final Map detailMap = new CustomData().detailMap;

  // 获取的数据
  Map map = {};
  bool flag = false;

  @override
  void initState() {
    getDetail();
    super.initState();
  }

  // 请求数据
  void getDetail() async {
    try {
      Dio dio = new Dio();
      Response response = await dio
          .get('http://m.maoyan.com/ajax/detailmovie?movieId=${widget.id}');

      // jsonDecode()  两种方法一致
      Map responseData = json.decode(response.toString());

      setState(() {
        map = responseData["detailMovie"];
        flag = true;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 我们在这里获取到 被控制组件的参数,需要使用 widget.来得到
        // widget就代表上面的组件
        title: Text('${widget.nm}'),
      ),
      body: ListView(
        children: <Widget>[
          // 顶部是一张大图
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 225,
                height: 315,
                margin: EdgeInsets.only(top: 60, bottom: 30),
                child: Image(
                  width: 225,
                  height: 315,
                  fit: BoxFit.cover,
                  image: flag == false
                      ? AssetImage('images/loading.png')
                      : NetworkImage('${_imgReset(map["img"])}'),
                ),
              )
            ],
          ),

          // 下面是一大堆的电影内容信息
          _TextItem(
            title: '名称',
            text: detailMap["nm"],
          ),
          _TextItem(
            title: '年代',
            text: detailMap["year"],
          ),
          _TextItem(
            title: '产地',
            text: detailMap["src"],
          ),
          _TextItem(
            title: '类别',
            text: detailMap["cat"],
          ),
          _TextItem(
            title: '语言',
            text: detailMap["language"],
          ),
          _TextItem(
            title: '上映日期',
            text: detailMap["comingTitle"],
          ),
          _TextItem(
            title: '豆瓣评分',
            text: detailMap["sc"],
          ),
          _TextItem(
            title: '片长',
            text: detailMap["howLong"],
          ),
          _TextItem(
            title: '导演',
            text: detailMap["director"],
          ),
          _TextItem(
            title: '主演',
            text: detailMap["star"],
            axisFlag: true,
          ),
          _TextItem(
            title: '简介',
            text: detailMap["dra"],
            axisFlag: true,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30),
          )
        ],
      ),
    );
  }

  String _imgReset(String img) => img.replaceAll('/w.h/', '/');
}

class _TextItem extends StatelessWidget {
  _TextItem({
    Key key,
    @required this.title,
    @required this.text,
    this.axisFlag,
  }) : super(key: key);

  final String title;
  final String text;
  final bool axisFlag;
  // 主演和简介的 文字内容较多，要单独处理。
  // 因此我们定义axisFlag 这个布尔值，当它为true，我们对我们的内容对齐单独处理

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: Row(
        crossAxisAlignment: axisFlag == true
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 85,
            child: title.length == 2
                ? Text('◎ ${title[0]}        ${title[1]}')
                : Text('◎ $title'),
          ),
          // 可以占据 除了左边85 之外的所有区域
          Expanded(
            child: Container(
              child: Text('$text'),
            ),
          ),
        ],
      ),
    );
  }
}
