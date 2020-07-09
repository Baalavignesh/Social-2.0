import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsocialmedia/screens/CategoryScreen.dart';
import 'package:newsocialmedia/screens/FriendsListScreen.dart';
import 'package:newsocialmedia/screens/FriendsPostScreen.dart';
import 'package:newsocialmedia/screens/MapScreen.dart';
import 'package:newsocialmedia/screens/PublicPostScreen.dart';
import 'package:newsocialmedia/screens/UserProfileScreenNearMe.dart';
import 'package:newsocialmedia/screens/WelcomeScreen.dart';
import 'package:newsocialmedia/services/MailAuth.dart';
import 'package:newsocialmedia/services/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';

class MainRoutePage extends StatefulWidget {
  static const String id = 'MainRoutePage';
  @override
  _MainRoutePageState createState() => _MainRoutePageState();
}

class _MainRoutePageState extends State<MainRoutePage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  final _store = Firestore.instance;
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    zUsername = (prefs.getString('username'));
    zUserMail = (prefs.getString('mail'));
    zCategory = (prefs.getStringList('category'));
    zDocumentID = (prefs.getString('documentid'));
    zLatitude = (prefs.getDouble('latitude'));
    zLongitude = (prefs.getDouble('longitude'));
    zCountry = (prefs.getString('country'));
    zDistrict = (prefs.getString('district'));
    zState = (prefs.getString('state'));
    print(zDocumentID);
    print(zCategory);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }

  askLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    print(_locationData);

    //Getting Address

    final coordinates =
        new Coordinates(_locationData.latitude, _locationData.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print(
        "${first.featureName} : ${first.addressLine} : ${first.subLocality} : ${first.subAdminArea} : ${first.adminArea} : ${first.countryName}");

    print(_locationData.longitude.runtimeType);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (_locationData != null) {
        await _store.collection('Users').document(zDocumentID).updateData({
          'lattitude': _locationData.latitude,
          'longitude': _locationData.longitude,
          'district': first.subAdminArea,
          'state': first.adminArea,
          'country': first.countryName,
        });
        prefs.setDouble('lattitude', _locationData.latitude);
        prefs.setDouble('longitude', _locationData.longitude);
        prefs.setString('district', first.subAdminArea);
        prefs.setString('country', first.countryName);
        prefs.setString('state', first.adminArea);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 3);
    print('MainRoutePage Screen');
    getData();
    askLocation();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBackground,
      appBar: AppBar(
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
            onPressed: () {
              Navigator.pushReplacementNamed(context, MainRoutePage.id);
            },
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
                              zUsername,
                              style: kTextStyle.copyWith(fontSize: 19),
                            ),
                          ),
                          Text(
                            zUserMail,
                            style: kTextStyle.copyWith(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                      title: ListData(text: 'Home', icon: Icon(Icons.home))),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, FriendsListScreen.id);
                    },
                    child: ListTile(
                        title: ListData(
                            text: 'Friends', icon: Icon(Icons.people))),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        secondTime = true;
                      });
                      Navigator.pushNamed(context, CategoryScreen.id);
                    },
                    child: ListTile(
                        title: ListData(
                            text: 'My Interest',
                            icon: Icon(Icons.playlist_add_check))),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, UserProfileScreenNearMe.id);
                    },
                    child: ListTile(
                        title: ListData(
                            text: 'My Profile', icon: Icon(Icons.face))),
                  ),
                  ListTile(
                      title: ListData(
                          text: 'Settings', icon: Icon(Icons.settings))),
                  GestureDetector(
                    onTap: () async {
                      AuthService().signOut();
                      secondTime = false;
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.clear();
                      Navigator.pushReplacementNamed(context, WelcomeScreen.id);
                    },
                    child: ListTile(
                        title: ListData(
                            text: 'Logout',
                            icon: FaIcon(FontAwesomeIcons.signOutAlt))),
                  ),
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

// Drawer Stuffs

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
