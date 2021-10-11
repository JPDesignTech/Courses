import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'provider/state_bloc.dart';
import 'provider/state_provider.dart';
import 'model/car.dart';

void main() {
  runApp(MyApp());
}

var currentCar = carList.cars[0];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(
            margin: EdgeInsets.only(left: 25),
            child: Icon(Icons.arrow_back, color: Colors.white)),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 25),
            child: Icon(Icons.favorite_border),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: MainLayout(),
    );
  }
}

class MainLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CarDetailsAnimation(),
        BottomLayerSheet(),
        RentCarButton()
      ],
    );
  }
}

// Rent Car Button Class
class RentCarButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        width: 200,
        child: FlatButton(
          onPressed: () {},
          child: Text(
            "Rent This Car",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                letterSpacing: 1.4,
                fontFamily: "arial"),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(35)),
          ),
          color: Colors.black,
          padding: EdgeInsets.all(25),
        ),
      ),
    );
  }
}

// Car Animations
class CarDetailsAnimation extends StatefulWidget {
  @override
  _CarDetailsAnimationState createState() => _CarDetailsAnimationState();
}

class _CarDetailsAnimationState extends State<CarDetailsAnimation>
    with TickerProviderStateMixin {
  AnimationController fadeOutContoller;
  AnimationController scaleCarController;

  Animation fadeOutAnimation;
  Animation scaleCarAnimation;

  @override
  void initState() {
    super.initState();

    fadeOutContoller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    scaleCarController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);

    fadeOutAnimation = Tween(begin: 0.0, end: 1.0).animate(fadeOutContoller);

    scaleCarAnimation = Tween(begin: 0.9, end: 1.0).animate(CurvedAnimation(
        parent: scaleCarController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeInOut));
  }

  forward() {
    scaleCarController.forward();
    fadeOutContoller.forward();
  }

  reverse() {
    scaleCarController.reverse();
    fadeOutContoller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        initialData: StateProvider().isAnimating,
        stream: stateBloc.animationStatus,
        builder: (context, snapshot) {
          snapshot.data ? forward() : reverse();
          return ScaleTransition(
            scale: scaleCarAnimation,
            child:
                FadeTransition(opacity: fadeOutAnimation, child: CarDetails()),
          );
        });
  }
}

class CarDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 30),
          child: _carTitle(),
        ),
        Container(
          width: double.infinity,
          child: CarCarousel(),
        )
      ],
    ));
  }

  _carTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
              style: TextStyle(color: Colors.white, fontSize: 35),
              children: [
                TextSpan(text: currentCar.companyName),
                TextSpan(text: "\n"),
                TextSpan(
                    text: currentCar.carModel,
                    style: TextStyle(fontWeight: FontWeight.bold))
              ]),
        ),
        SizedBox(height: 10),
        RichText(
          text: TextSpan(style: TextStyle(fontSize: 16), children: [
            TextSpan(
                text: '\$' + currentCar.price.toString(),
                style: TextStyle(color: Colors.grey[20])),
            TextSpan(text: ' per Day', style: TextStyle(color: Colors.grey)),
          ]),
        )
      ],
    );
  }
}

class CarCarousel extends StatefulWidget {
  @override
  _CarCarouselState createState() => _CarCarouselState();
}

class _CarCarouselState extends State<CarCarousel> {
  static final List<String> imgsList = currentCar.imgsList;

  final List<Widget> child = _map<Widget>(imgsList, (index, String assetName) {
    return Container(
        child: Image.asset("assets/$assetName", fit: BoxFit.fitWidth));
  }).toList();

  static List<T> _map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        CarouselSlider(
          height: 250,
          viewportFraction: 1.0,
          items: child,
          onPageChanged: (index) {
            setState(() {
              _current = index;
            });
          },
        ),
        Container(
            margin: EdgeInsets.only(left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _map<Widget>(imgsList, (index, assetName) {
                return Container(
                  width: 50,
                  height: 2,
                  decoration: BoxDecoration(
                      color: _current == index
                          ? Colors.grey[100]
                          : Colors.grey[600]),
                );
              }),
            ))
      ],
    ));
  }
}

class BottomLayerSheet extends StatefulWidget {
  @override
  _BottomLayerSheet createState() => _BottomLayerSheet();
}

class _BottomLayerSheet extends State<BottomLayerSheet>
    with SingleTickerProviderStateMixin {
  double sheetTop = 400;
  double minSheetTop = 30;

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    animation = Tween<double>(begin: sheetTop, end: minSheetTop).animate(
        CurvedAnimation(
            parent: controller,
            curve: Curves.easeInOut,
            reverseCurve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });
  }

  forwardAnimation() {
    controller.forward();
    stateBloc.toggleAnimation();
  }

  reverseAnimation() {
    controller.reverse();
    stateBloc.toggleAnimation();
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: animation.value,
        left: 0,
        child: GestureDetector(
          onTap: () {
            controller.isCompleted ? reverseAnimation() : forwardAnimation();
          },
          onVerticalDragEnd: (DragEndDetails dragEnd) {
            if (dragEnd.primaryVelocity < 0.0) {
              forwardAnimation();
              controller.forward();
            } else if (dragEnd.primaryVelocity > 0.0) {
              reverseAnimation();
            } else {
              return;
            }
          },
          child: SheetContainer(),
        ));
  }
}

class SheetContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sheetItemHeight = 110;
    return Container(
        padding: EdgeInsets.only(top: 25),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            color: Color(0xffd9dbdb)),
        child: Column(
          children: <Widget>[
            drawerHandle(),
            Expanded(
                flex: 1,
                child: ListView(
                  children: <Widget>[
                    carDetail(sheetItemHeight),
                    carSpecs(sheetItemHeight),
                    carFeat(sheetItemHeight),
                    SizedBox(height: 220)
                  ],
                ))
          ],
        ));
  }

  drawerHandle() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      height: 3,
      width: 65,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Color(0xffd9dbdb)),
    );
  }

  carSpecs(double itemHeight) {
    return Container(
        padding: EdgeInsets.only(top: 15, left: 40),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Specifications",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
              Container(
                  margin: EdgeInsets.only(top: 15),
                  height: itemHeight,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: currentCar.carSpecifications.length,
                    itemBuilder: (context, index) {
                      return ListItem(
                        sheetItemHeight: itemHeight,
                        mapVal: currentCar.carSpecifications[index],
                      );
                    },
                  ))
            ]));
  }

  carFeat(double itemHeight) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Features',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            height: itemHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: currentCar.carFeatures.length,
              itemBuilder: (context, index) {
                return ListItem(
                  sheetItemHeight: itemHeight,
                  mapVal: currentCar.carFeatures[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  carDetail(double itemHeight) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Offer Details",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            height: itemHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: currentCar.carInformation.length,
              itemBuilder: (context, index) {
                return ListItem(
                  sheetItemHeight: itemHeight,
                  mapVal: currentCar.carInformation[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final double sheetItemHeight;
  final Map mapVal;

  ListItem({this.sheetItemHeight, this.mapVal});

  @override
  Widget build(BuildContext context) {
    var innerMap;
    bool isMap;

    if (mapVal.values.elementAt(0) is Map) {
      innerMap = mapVal.values.elementAt(0);
      isMap = true;
    } else {
      innerMap = mapVal;
      isMap = false;
    }

    return Container(
      margin: EdgeInsets.only(right: 20),
      width: sheetItemHeight,
      height: sheetItemHeight,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          mapVal.keys.elementAt(0),
          isMap
              ? Text(innerMap.keys.elementAt(0),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, letterSpacing: 1.2, fontSize: 11))
              : Container(),
          Text(
            innerMap.values.elementAt(0),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
