import 'package:flutter/material.dart';
import 'package:newsocialmedia/screens/SinglePostScreen.dart';
import 'package:newsocialmedia/services/constants.dart';

import 'package:flutter/scheduler.dart';
import 'package:animations/animations.dart';
import 'package:newsocialmedia/tabs/PostTab.dart';
import 'package:newsocialmedia/tabs/TimelineTab.dart';
import 'package:page_transition/page_transition.dart';

class UserProfileScreen extends StatefulWidget {
  static const String id = 'UserProfileScreen';
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<Container> top = [];

  List<Widget> topContent() {
    Container one = Container(
      color: kDarkBackground,
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 85,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('images/logomain.png'),
            ),
          ),
          Column(
            children: <Widget>[
              Text(
                'Baalavignesh Arunachalam',
                style: kTextStyle,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '@pableboo',
                style: kTextStyle.copyWith(color: Colors.grey),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Followers',
                      style: kTextStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '424k',
                      style: kTextStyle.copyWith(
                          fontSize: 30, fontFamily: 'NexaBold'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Following',
                      style: kTextStyle,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '840',
                      style: kTextStyle.copyWith(
                        fontSize: 30,
                        fontFamily: 'NexaBold',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.white)),
                child: Center(
                  child: isMe
                      ? Text(
                          'Follow',
                          style: kTextStyle,
                          textAlign: TextAlign.center,
                        )
                      : null,
                )),
          ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
    top.add(one);
    return top;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(
        backgroundColor: kDarkBackground,
        title: Text(
          'Profile',
          style: kTextStyle,
        ),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  topContent(),
                ),
              ),
            ];
          },
          body: Column(
            children: <Widget>[
              TabBar(
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.photo),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Post',
                          style: kTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.timeline),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Timeline',
                          style: kTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    PostTab(),
                    TimelineTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
