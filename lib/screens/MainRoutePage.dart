import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:newsocialmedia/screens/FriendsPostScreen.dart';
import 'package:newsocialmedia/screens/MapScreen.dart';
import 'package:newsocialmedia/screens/PublicPostScreen.dart';
import 'package:newsocialmedia/screens/SignUpScreen.dart';
import 'package:newsocialmedia/screens/UserProfileScreen.dart';
import 'package:newsocialmedia/screens/WelcomeScreen.dart';
import 'package:newsocialmedia/services/constants.dart';
import 'package:page_transition/page_transition.dart';

class MainRoutePage extends StatefulWidget {
  static const String id = 'MainRoutePage';
  @override
  _MainRoutePageState createState() => _MainRoutePageState();
}

class _MainRoutePageState extends State<MainRoutePage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  ScrollController _scrollController;
  bool scrollDirection;

  @override
  void initState() {
    super.initState();
    print('inside');

    controller = TabController(vsync: this, length: 3);
    _scrollController = ScrollController()
      ..addListener(() {
        print('please');
        scrollDirection = _scrollController.position.userScrollDirection ==
            ScrollDirection.forward;
        print('hello');
        print(scrollDirection);
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        leading: IconButton(
//          icon: Icon(
//            Icons.menu,
//            color: Colors.white,
//          ),
//        ),
        backgroundColor: kDarkBackground,

        title: Image.asset(
          'images/logomain.png',
          fit: BoxFit.contain,
          height: 42,
        ),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {},
          ),
          new IconButton(
            icon: new Icon(Icons.mail),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          unselectedLabelColor: Colors.blueGrey,
          labelColor: Colors.white,
          controller: controller,
          tabs: <Tab>[
            new Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.people),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Public',
                    style: kTextStyle,
                  ),
                ],
              ),
            ),
            new Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.person),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Friends',
                    style: kTextStyle,
                  ),
                ],
              ),
            ),
            new Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.location_on),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Map',
                    style: kTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: kDarkBackground,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 250,
                    width: double.infinity,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor: kDarkBackground,
                              child: Text(
                                "P",
                                style: TextStyle(fontSize: 40.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              "Baalavignesh Arunachalam",
                              style: kTextStyle.copyWith(fontSize: 19),
                            ),
                          ),
                          Text(
                            "baalavignesh21@gmail.com",
                            style: kTextStyle.copyWith(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                      title: ListData(text: 'Home', icon: Icon(Icons.home))),
                  ListTile(
                      title:
                          ListData(text: 'Friends', icon: Icon(Icons.people))),
                  ListTile(
                      title: ListData(
                          text: 'Find People', icon: Icon(Icons.explore))),
                  ListTile(
                      title: ListData(
                          text: 'My Interest',
                          icon: Icon(Icons.playlist_add_check))),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, UserProfileScreen.id);
                    },
                    child: ListTile(
                        title: ListData(
                            text: 'My Profile', icon: Icon(Icons.face))),
                  ),
                  ListTile(
                      title: ListData(
                          text: 'Settings', icon: Icon(Icons.settings))),
                ],
              )
            ],
          ),
        ),
      ),
      body: Container(
        color: kDarkBackground,
        child: TabBarView(
          controller: controller,
          children: [
            PublicPostScreen(),
            FriendsPostScreen(),
            MapScreen(),
          ],
        ),
      ),
    );
  }
}

class ListData extends StatelessWidget {
  final text;
  final icon;
  final onPress;
  const ListData({this.text, this.icon, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: icon,
        ),
        Expanded(
            child: Text(
          text,
          style: kTextStyle,
        )),
      ],
    );
  }
}
