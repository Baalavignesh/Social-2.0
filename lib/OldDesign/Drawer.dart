//drawer: Drawer(
//child: Container(
//color: kDarkBackground,
//child: ListView(
//scrollDirection: Axis.vertical,
//children: <Widget>[
//Column(
//mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
//Container(
//height: 250,
//width: double.infinity,
//child: DrawerHeader(
//decoration: BoxDecoration(
//color: Colors.blueGrey,
//),
//child: Column(
//mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
//Padding(
//padding: const EdgeInsets.only(bottom: 20),
//child: CircleAvatar(
//radius: 35,
//backgroundColor: kDarkBackground,
//child: Text(
//"P",
//style: TextStyle(fontSize: 40.0),
//),
//),
//),
//Padding(
//padding: const EdgeInsets.only(bottom: 10),
//child: Text(
//zUsername,
//style: kTextStyle.copyWith(fontSize: 19),
//),
//),
//Text(
//zUserMail,
//style: kTextStyle.copyWith(fontSize: 15),
//),
//],
//),
//),
//),
//ListTile(
//title: ListData(text: 'Home', icon: Icon(Icons.home))),
//GestureDetector(
//onTap: () {
//Navigator.pushNamed(context, FriendsListScreen.id);
//},
//child: ListTile(
//title: ListData(
//text: 'Friends', icon: Icon(Icons.people))),
//),
//GestureDetector(
//onTap: () {
//setState(() {
//secondTime = true;
//});
//Navigator.pushNamed(context, CategoryScreen.id);
//},
//child: ListTile(
//title: ListData(
//text: 'My Interest',
//icon: Icon(Icons.playlist_add_check))),
//),
//GestureDetector(
//onTap: () {
//Navigator.pushNamed(context, UserProfileScreenNearMe.id);
//},
//child: ListTile(
//title: ListData(
//text: 'My Profile', icon: Icon(Icons.face))),
//),
//ListTile(
//title: ListData(
//text: 'Settings', icon: Icon(Icons.settings))),
//GestureDetector(
//onTap: () async {
//AuthService().signOut();
//secondTime = false;
//SharedPreferences preferences =
//    await SharedPreferences.getInstance();
//preferences.clear();
//Navigator.pushReplacementNamed(context, WelcomeScreen.id);
//},
//child: ListTile(
//title: ListData(
//text: 'Logout',
//icon: FaIcon(FontAwesomeIcons.signOutAlt))),
//),
//],
//)
//],
//),
//),
//),
