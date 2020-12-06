import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:async';
import 'package:space_slot/sound_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> imgList = [
  'images/sign1.png',
  'images/sign2.png',
  'images/sign3.png'
];

int speedSlots = 100;
bool statusLeftSlot = false;
bool statusCenterSlot = false;
bool statusRightSlot = false;
int valueLeftSlot;
int valueCenterSlot;
int valueRightSlot;
double filterFirstStar = 0;
double filterSecondStar = 0;
double filterThirdStar = 0;
double filterFourthStar = 0;
double filterFifthStar = 1;
double i = 0;
double j = 0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void startAllSlots() {
    if (!statusLeftSlot && !statusRightSlot && !statusCenterSlot) {
      setState(() {
        statusLeftSlot = true;
        statusCenterSlot = true;
        statusRightSlot = true;
      });
      play.playHandler();
    }
  }

  void stopAllSlot() {
    if (statusLeftSlot && statusRightSlot && statusCenterSlot) {
      setState(() {
        statusLeftSlot = false;
        // print(left);
      });
      Timer(Duration(seconds: 1), () {
        setState(() {
          statusRightSlot = false;
          // print(right);
        });
      });

      Timer(Duration(seconds: 2), () {
        setState(() {
          statusCenterSlot = false;

          play.playHandler();
        });
      });
    }
  }

  void searchMatch() {
    valueLeftSlot = valueLeftSlot == 0 ? 2 : valueLeftSlot - 1;
    valueCenterSlot = valueCenterSlot == 0 ? 2 : valueCenterSlot - 1;
    valueRightSlot = valueRightSlot == 0 ? 2 : valueRightSlot - 1;
    if (!statusLeftSlot && !statusRightSlot && !statusCenterSlot) {
      if (imgList[valueLeftSlot] == imgList[valueRightSlot] &&
          imgList[valueLeftSlot] == imgList[valueCenterSlot]) {
        i += 1;
        saveData();
        readData();
      }
    }
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('i', i);

    if (i == 1) {
      prefs.setDouble('color1', 1);
      prefs.setDouble('j', 5);
    } else if (i == 5) {
      prefs.setDouble('color2', 1);
      prefs.setDouble('j', 10);
    } else if (i == 10) {
      prefs.setDouble('j', 20);
      prefs.setDouble('color3', 1);
    } else if (i == 20) {
      prefs.setDouble('color4', 1);
      prefs.setDouble('j', 30);
    } else if (i == 30) {
      prefs.setDouble('color5', 1);
      prefs.setDouble('j', 40);
    } else if (i == 40) {
      prefs.remove('color1');
      prefs.remove('color2');
      prefs.remove('color3');
      prefs.remove('color4');
      prefs.remove('color5');
      prefs.remove('i');
      prefs.remove('j');
    }
  }

  void readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      filterFirstStar = prefs.getDouble('color1') ?? 0.0;
      filterSecondStar = prefs.getDouble('color2') ?? 0.0;
      filterThirdStar = prefs.getDouble('color3') ?? 0.0;
      filterFourthStar = prefs.getDouble('color4') ?? 0.0;
      filterFifthStar = prefs.getDouble('color5') ?? 0.0;

      i = prefs.getDouble('i') ?? 0.0;
      j = prefs.getDouble('j') ?? 1.0;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Positioned(
              top: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StarWidget(
                    filterStar: filterFirstStar,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  StarWidget(
                    filterStar: filterSecondStar,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  StarWidget(
                    filterStar: filterThirdStar,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  StarWidget(
                    filterStar: filterFourthStar,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  StarWidget(
                    filterStar: filterFifthStar,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 130,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color.fromARGB(150, 47, 79, 79),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 85,
                      height: 130,
                      child: CarouselSlider.builder(
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int itemIndex) =>
                            Container(
                          child: Image(
                            image:
                                AssetImage(imgList[valueLeftSlot = itemIndex]),
                          ),
                        ),
                        options: CarouselOptions(
                          autoPlay: statusLeftSlot,
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,
                          initialPage: 0,
                          autoPlayInterval: Duration(milliseconds: speedSlots),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: speedSlots),
                          autoPlayCurve: Curves.linear,
                          scrollDirection: Axis.vertical,
                        ),
                      ),
                    ),
                    Container(
                      width: 85,
                      height: 130,
                      child: CarouselSlider.builder(
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int itemIndex) =>
                            Container(
                          child: Image(
                            image: AssetImage(
                                imgList[valueCenterSlot = itemIndex]),
                          ),
                        ),
                        options: CarouselOptions(
                          autoPlay: statusCenterSlot,
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,

                          initialPage: 1,
                          // reverse: true,
                          autoPlayInterval: Duration(milliseconds: speedSlots),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: speedSlots),
                          autoPlayCurve: Curves.linear,
                          scrollDirection: Axis.vertical,
                        ),
                      ),
                    ),
                    Container(
                      width: 85,
                      height: 130,
                      // color: Colors.white,
                      child: CarouselSlider.builder(
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int itemIndex) =>
                            Container(
                          child: Image(
                            image: AssetImage(
                              imgList[valueRightSlot = itemIndex],
                            ),
                          ),
                        ),
                        options: CarouselOptions(
                          autoPlay: statusRightSlot,
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,

                          initialPage: 2,
                          // reverse: true,
                          autoPlayInterval: Duration(milliseconds: speedSlots),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: speedSlots),
                          autoPlayCurve: Curves.linear,
                          scrollDirection: Axis.vertical,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 130,
              child: Container(
                width: 300,
                height: 150,
                color: Colors.transparent,
              ),
            ),
            Positioned(
              bottom: 240,
              child: Text(
                '${i.round()} / ${j.round()}',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 232, 31),
                  fontWeight: FontWeight.normal,
                  fontSize: 22,
                  fontFamily: ('Star'),
                ),
              ),
            ),
            Positioned(
              bottom: 90,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 0, 139, 139),
                        Color.fromARGB(255, 0, 206, 209),
                        Color.fromARGB(255, 0, 139, 139),
                      ]),
                ),
                child: FlatButton(
                  onPressed: () {
                    startAllSlots();
                  },
                  minWidth: 290,
                  height: 50,
                  child: Text(
                    'START',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 232, 31),
                      fontSize: 25,
                      fontFamily: ('Star'),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 255, 0, 0),
                        Color.fromARGB(255, 255, 99, 71),
                        Color.fromARGB(255, 255, 0, 0),
                      ]),
                ),
                child: FlatButton(
                  onPressed: () {
                    stopAllSlot();
                    Timer(
                      Duration(milliseconds: 2500),
                      searchMatch,
                    );
                  },
                  minWidth: 290,
                  height: 50,
                  child: Text(
                    'STОP',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 232, 31),
                      fontSize: 25,
                      fontFamily: ('Star'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StarWidget extends StatelessWidget {
  final double filterStar;
  StarWidget({@required this.filterStar});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/star.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.transparent.withOpacity(filterStar), BlendMode.dstIn),
        ),
      ),
    );
  }
}
