import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsocialmedia/screens/FriendsPostScreen.dart';
import 'package:newsocialmedia/screens/MapScreen.dart';
import 'package:newsocialmedia/screens/PublicPostScreen.dart';
import 'package:newsocialmedia/screens/UserProfileScreen.dart';
import 'package:newsocialmedia/services/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'dart:async';
import 'dart:io';
import 'CaptionAndImageScreen.dart';

class MainRoutePage extends StatefulWidget {
  static const String id = 'MainRoutePage';
  @override
  _MainRoutePageState createState() => _MainRoutePageState();
}

class _MainRoutePageState extends State<MainRoutePage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  final _store = Firestore.instance;
  final picker = ImagePicker();

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

  getImageCamera() async {
    try {
      final pickedFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 60,
      );

      setState(() {
        zImageToBeUploaded = File(pickedFile.path);
      });
      Navigator.pop(context);
      Navigator.pushNamed(context, CaptionAndImageScreen.id);
    } catch (e) {
      print(e);
    }
  }

  getImageGallery() async {
    try {
      final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 60,
      );

      setState(() {
        zImageToBeUploaded = File(pickedFile.path);
      });
      Navigator.pop(context);
      Navigator.pushNamed(context, CaptionAndImageScreen.id);
    } catch (e) {
      print(e);
    }
  }

  bottomModal() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.image),
                    title: new Text('Gallery'),
                    onTap: () async {
                      await getImageGallery();
                    }),
                new ListTile(
                  leading: new Icon(Icons.camera_alt),
                  title: new Text('Camera'),
                  onTap: () {
                    getImageCamera();
                  },
                ),
              ],
            ),
          );
        });
  }

  getRadianFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 3);
    print('MainRoutePage Screen');
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
            icon: new Icon(FontAwesomeIcons.inbox),
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
      body: Container(
        color: kDarkBackground,
        child: Stack(
          children: <Widget>[
            TabBarView(
              controller: controller,
              children: [
                PublicPostScreen(),
                FriendsPostScreen(),
                MapScreen(),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.home_menu,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        overlayColor: kBackground,
        visible: dialVisible,
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
        curve: Curves.easeIn,
        children: [
          SpeedDialChild(
            child: Icon(Icons.camera),
            label: 'Post',
            labelBackgroundColor: Colors.black,
            onTap: () {
              bottomModal();
            },
            backgroundColor: Colors.redAccent,
          ),
          SpeedDialChild(
            child: Icon(Icons.person),
            label: 'Profile',
            labelBackgroundColor: Colors.black,
            onTap: () {
              Navigator.pushNamed(context, UserProfileScreen.id);
            },
            backgroundColor: Colors.green,
          ),
          SpeedDialChild(
            child: Icon(Icons.brush),
            label: 'Say Something',
            labelBackgroundColor: Colors.black,
            onTap: () {},
            backgroundColor: Colors.indigoAccent,
          ),
        ],
        marginRight: 30,
        marginBottom: 30,
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final width;
  final height;
  final icon;
  final color;
  final onPress;

  CircularButton(
      {this.height, this.width, this.color, this.icon, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(
        icon: icon,
        enableFeedback: true,
        onPressed: onPress,
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
