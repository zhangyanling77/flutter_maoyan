import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
// 引入dio库 引入convert做数据解析
import 'package:dio/dio.dart';
import 'dart:convert';

// 动态组件
class CinemaList extends StatefulWidget {
  @override
  _CinemaListState createState() => _CinemaListState();
}

// 控制器
class _CinemaListState extends State<CinemaList> {
/*
  List cinemas = [
    {
      "id": 9647,
      "mark": 0,
      "nm": "沃美影城（回龙观店）",
      "sellPrice": "39",
      "addr": "昌平区回龙观同成街华联购物中心四楼（城铁回龙观站出口对面）",
      "distance": "1.1km",
      "tag": {
        "allowRefund": 0,
        "buyout": 0,
        "cityCardTag": 0,
        "deal": 0,
        "endorse": 0,
        "hallType": [
          "杜比全景声厅",
          "DTS:X 临境音厅",
          "4K厅",
        ],
        "hallTypeVOList": [
          {"name": "杜比全景声厅", "url": ""}
        ],
        "sell": 1,
        "snack": 1,
        "vipTag": "折扣卡"
      },
      "promotion": {
        "cardPromotionTag": "开卡特惠，首单2张最高立减4元",
      },
    },
  ];
*/
  // 定义当前页面使用的数据
  List cinemas = [];

  // 存储当前页面需要的三种颜色
  // 红色
  Color color0 = Color.fromARGB(255, 240, 61, 55);
  // 橙色
  Color color1 = Color.fromARGB(255, 255, 153, 0);
  // 黄绿色
  Color color2 = Color.fromARGB(255, 88, 157, 175);

  // 我们需要一个函数 对tag 进行处理， 然后根据实际值进行渲染
  List<Widget> tagWidgets(tag) {
    // tag标签的数组
    List<Widget> tagList = [];

    // 退
    if (tag["allowRefund"] == 1) {
      tagList.add(CinemaTag(
        color: color2,
        text: '退',
      ));
    }

    // 改签
    if (tag["endorse"] == 1) {
      tagList.add(CinemaTag(
        color: color2,
        text: '改签',
      ));
    }

    // 小吃
    if (tag["snack"] == 1) {
      tagList.add(CinemaTag(
        color: color1,
        text: '小吃',
      ));
    }

    // 折扣卡
    if (tag["vipTag"] is String && tag["vipTag"].length > 0) {
      tagList.add(CinemaTag(
        color: color1,
        text: tag["vipTag"],
      ));
    }

    // 影厅部分
    if (tag["hallType"] is List) {
      tag["hallType"].forEach((str) {
        tagList.add(CinemaTag(
          color: color2,
          text: str,
        ));
      });
    }

    return tagList;
  }

  @override
  void initState() {
    getCinemaList();
    super.initState();
  }

  // 获取数据
  void getCinemaList() async {
    try {
      Dio dio = new Dio();
      Response response = await dio.get(
          'http://m.maoyan.com/ajax/cinemaList?day=2019-09-28&offset=0&limit=20&districtId=-1&lineId=-1&hallType=-1&brandId=-1&serviceId=-1&areaId=-1&stationId=-1&item=&updateShowDay=true&reqId=1569654378453&cityId=1');

      Map responseData = jsonDecode(response.toString());

      setState(() {
        cinemas = responseData["cinemas"];
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        // 遍历的次数
        itemCount: cinemas.length,
        // 每次遍历都要执行后面的回调函数
        itemBuilder: (BuildContext context, int i) {
          Map _cinema = cinemas[i];
          return Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                // 第一行 名称和价格
                Padding(
                  padding: EdgeInsets.only(bottom: 3),
                  child: Row(
                    // 三行文字底部对齐
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '${_cinema["nm"]}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${_cinema["sellPrice"]}',
                        style: TextStyle(color: color0, fontSize: 18),
                      ),
                      Text(
                        '元起',
                        style: TextStyle(color: color0, fontSize: 12),
                      )
                    ],
                  ),
                ),

                // 第二行 地址和距离
                Padding(
                  padding: EdgeInsets.only(bottom: 3),
                  child: Row(
                    children: <Widget>[
                      // 弹性盒子，可以占据多余的空间
                      Expanded(
                        child: Text(
                          '${_cinema["addr"]}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: Color.fromARGB(255, 102, 102, 102)),
                        ),
                      ),
                      Text(
                        '${_cinema["distance"]}',
                        style: TextStyle(
                            color: Color.fromARGB(255, 102, 102, 102)),
                      ),
                    ],
                  ),
                ),

                // 第三行 tag标签
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: tagWidgets(_cinema["tag"]),
                  ),
                ),

                // 第四行 一个icon 和优惠信息
                _cinema["promotion"]["cardPromotionTag"] is String
                    ? Row(
                        children: <Widget>[
                          // 图标
                          Container(
                            width: 17,
                            height: 17,
                            margin: EdgeInsets.only(right: 5),
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage('images/card.png'),
                            ),
                          ),

                          // 优惠信息
                          Text(
                            '${_cinema["promotion"]["cardPromotionTag"]}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 153, 153, 153),
                            ),
                          )
                        ],
                      )
                    : Container(),
              ],
            ),
          );
        },
      ),
    );
  }
}

// 第三行的标签
class CinemaTag extends StatelessWidget {
  CinemaTag({Key key, @required this.text, @required this.color})
      : super(key: key);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        // 边框
        border: Border.all(
          color: color,
        ),
        // 圆角
        borderRadius: BorderRadius.all(
          Radius.circular(3),
        ),
      ),
      padding: EdgeInsets.fromLTRB(2, 0, 2, 1),
      child: Text(
        '$text',
        style: TextStyle(color: color, fontSize: 11),
      ),
    );
  }
}
