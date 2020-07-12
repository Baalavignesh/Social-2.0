// Style floating button
//          AnimationController animationController;
//          Animation degOneTranslationAnimation;

//            animationController =
//                AnimationController(vsync: this, duration: Duration(milliseconds: 200));
//            degOneTranslationAnimation =
//            Tween(begin: 0.0, end: 1.0).animate(animationController);
//          super.initState();
//
//        animationController.addListener(() {
//      setState(() {});
//    });
//              Positioned(
//                bottom: 30,
//                right: 30,
//                child: Stack(
//                  children: <Widget>[
//                    Transform.translate(
//                      offset: Offset.fromDirection(getRadianFromDegree(180),
//                          degOneTranslationAnimation.value * 100),
//                      child: CircularButton(
//                        icon: Icon(Icons.add),
//                        color: Colors.green,
//                        width: 50.0,
//                        height: 50.0,
//                        onPress: () {
//                          print('add button');
//                        },
//                      ),
//                    ),
//                    Transform.translate(
//                      offset: Offset.fromDirection(getRadianFromDegree(225),
//                          degOneTranslationAnimation.value * 100),
//                      child: CircularButton(
//                        icon: Icon(Icons.camera),
//                        color: Colors.blueAccent,
//                        width: 50.0,
//                        height: 50.0,
//                        onPress: () {
//                          print('camera button');
//                        },
//                      ),
//                    ),
//                    Transform.translate(
//                      offset: Offset.fromDirection(getRadianFromDegree(270),
//                          degOneTranslationAnimation.value * 100),
//                      child: CircularButton(
//                        icon: Icon(FontAwesomeIcons.userAlt),
//                        color: Colors.yellow,
//                        width: 50.0,
//                        height: 50.0,
//                        onPress: () {
//                          print('profile button');
//                        },
//                      ),
//                    ),
//                    CircularButton(
//                      icon: Icon(Icons.menu),
//                      color: Colors.indigo,
//                      width: 60.0,
//                      height: 60.0,
//                      onPress: () {
//                        print('menu button');
//                        if (animationController.isCompleted) {
//                          print('end');
//                          animationController.reverse();
//                        } else {
//                          print('start');
//                          animationController.forward();
//                        }
//                      },
//                    )
//                  ],
//                ),
//              )
