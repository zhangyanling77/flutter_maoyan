import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// 引入三个页面
import 'HomeBody.dart';
import '../movie/MovieList.dart';
import '../cinema/CinemaList.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    // 控制器，导航和页面的联动效果需要一个控制器去控制，这个组件直接帮助我们添加好了
    return DefaultTabController(
      // 控制器控制页面切换的数量，页面和导航的数量要一致
      length: 3,
      // 脚手架工具
      child: Scaffold(
        // 顶部导航
        appBar: AppBar(
          title: Text('moumou影院'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),

        // 侧边栏
        drawer: Drawer(
          // ListView是从上到下排列的盒子容器，当然也能都从左网友列
          child: ListView(
            // 去掉顶部的padding间距
            padding: EdgeInsets.all(0),
            // 尖括号里面 代表对数组内部的每一项规定数据类型
            children: <Widget>[
              // 侧边栏头部
              UserAccountsDrawerHeader(
                accountName: Text('一江西流'),
                accountEmail: Text('18783226594@163.com'),
                // 头像区域
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://upload.jianshu.io/users/upload_avatars/12442310/e11b2581-d89e-406e-95bc-5e1421066549.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240'),
                ),
                // 装饰器
                decoration: BoxDecoration(
                    image: DecorationImage(
                        // 图片填充, cover 代表自适应填充，但是会被裁切
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1565519039005&di=c5e788e9d717b63bb865b50fcf2dd855&imgtype=0&src=http%3A%2F%2Fi9.hexun.com%2F2018-11-24%2F195299307.jpg'))),
              ),

              ListTile(
                title: Text('我的发布'),
                trailing: Icon(Icons.send),
              ),
              ListTile(
                title: Text('我的收藏'),
                trailing: Icon(Icons.feedback),
              ),
              ListTile(
                title: Text('系统设置'),
                trailing: Icon(Icons.settings),
              ),
              // Color.fromARGB(a, r, g, b) 自定义颜色， a写255
              Divider(color: Colors.black45),
              ListTile(
                title: Text('注销'),
                trailing: Icon(Icons.exit_to_app),
              ),
            ],
          ),
        ),

        // 页面需要传递 TabBarView, 来实现联动效果
        body: TabBarView(
          children: <Widget>[
            HomeBody(),
            MovieList(),
            CinemaList()
          ],
        ),

        // 底部导航
        bottomNavigationBar: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black
          ),
          // TabBar 是系统提供的底部导航组件，可以实现与页面的联动效果
          child: TabBar(
            labelStyle: TextStyle(
              // 指字符的高度
              height: 0,
              fontSize: 11
            ),
            tabs: <Widget>[
              Tab(text: '首页', icon: Icon(Icons.home)),
              Tab(text: '正在热映', icon: Icon(Icons.movie_creation)),
              Tab(text: '影院信息', icon: Icon(Icons.local_movies)),
            ],
          ),
        ),
      ),
    );
  }
}
