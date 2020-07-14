import 'package:flutter/material.dart';

class TinyPost extends StatefulWidget {
  final image;
  final isPotrait;
  final onTap;
  TinyPost({this.image, this.onTap, this.isPotrait});
  @override
  _TinyPostState createState() => _TinyPostState();
}

class _TinyPostState extends State<TinyPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            this.widget.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
