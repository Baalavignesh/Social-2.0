import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsocialmedia/services/constants.dart';
import 'package:newsocialmedia/tabs/FindFriendsTab.dart';
import 'package:newsocialmedia/tabs/FriendRequestTab.dart';

class FriendsListScreen extends StatefulWidget {
  static const String id = "FriendsListScreen";
  @override
  _FriendsListScreenState createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends State<FriendsListScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  clearAllVariable() {
    print('calling');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Friends List Screen');
    controller = TabController(vsync: this, length: 2);
    clearAllVariable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(
        backgroundColor: kDarkBackground,
        title: Text('Friends List'),
        bottom: TabBar(
          unselectedLabelColor: Colors.blueGrey,
          labelColor: Colors.white,
          controller: controller,
          tabs: <Tab>[
            new Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(FontAwesomeIcons.userFriends),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Friend Request',
                    style: kTextStyle,
                  ),
                ],
              ),
            ),
            new Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(FontAwesomeIcons.users),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Near Me',
                    style: kTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: kDarkBackground,
        child: TabBarView(
          controller: controller,
          children: [
            FriendRequestTab(),
            FindFriendsTab(),
          ],
        ),
      ),
    );
  }
}
