import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:newsocialmedia/reusables/TinyPost.dart';
import 'package:newsocialmedia/services/constants.dart';

class PinScreen extends StatefulWidget {
  static const String id = 'PinScreen';
  @override
  _PinScreenState createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: zMyPost.length,
          itemBuilder: (BuildContext context, int index) => TinyPost(
            image: zMyPost[index]['url'],
          ),
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(2, index.isEven ? 2 : 1),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
    );
  }
}
