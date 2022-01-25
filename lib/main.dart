import 'dart:math';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

void main() {
  runApp(
    WithBuilder(),
  );
}

class ItemData {
  final Color color;
  final String image;
  final String text1;
  final String text2;
  final String text3;

  ItemData(this.color, this.image, this.text1, this.text2, this.text3);
}

class WithBuilder extends StatefulWidget {
  @override
  _WithBuilder createState() => _WithBuilder();
}

class _WithBuilder extends State<WithBuilder> {
  int page = 0;
  var liquidController;
  var updateType;

  List<ItemData> data = [
    ItemData(Colors.blue, "assets/1.png", "Taj Mahal", "Location: Agra, Uttar Pradesh, India", "Architect: Ustad Ahmad Lahauri"),
    ItemData(Colors.deepPurpleAccent, "assets/2.png", "Buckingham Palace", "Location: Westminster, London", "Architect: William Winde"),
    ItemData(Colors.green, "assets/3.png", "Sydney Opera House", "Location: Bennelong Point, Sydney", "Architect: Jørn Utzon"),
    ItemData(Colors.yellow, "assets/4.png", "Leaning Tower of Pisa", "Location: Pisa, Italy", "Architect: Bonanno Pisano"),
    ItemData(Colors.red, "assets/5.png", "Hagia Sophia", "Location: Fatih, Istanbul, Turkey", "Architect: Isidore of Miletus, Anthemius of Tralles"),
  ];

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: 25.0,
      child: new Center(
        child: new Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: new Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('World Famous Buildings'),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            LiquidSwipe.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  color: data[index].color,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset(
                          data[index].image,
                          height: 400,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              data[index].text1,
                              style: WithPages.style,
                            ),
                            Text(
                              data[index].text2,
                              style: WithPages.style,
                            ),
                            Text(
                              data[index].text3,
                              style: WithPages.style,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              positionSlideIcon: 0.8,
              slideIconWidget: Icon(Icons.arrow_back_ios),
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              fullTransitionValue: 880,
              enableSideReveal: true,
              enableLoop: true,
              ignoreUserGestureWhileAnimating: true,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(data.length, _buildDot),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: FlatButton(
                  onPressed: () {
                    liquidController.animateToPage(
                        page: data.length - 1, duration: 700);
                  },
                  child: Text("Skip to End", style: TextStyle(backgroundColor: Color(0xfff5f6fa),),),
                  color: Colors.white.withOpacity(0.01),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: FlatButton(
                  onPressed: () {
                    liquidController.jumpToPage(
                        page: liquidController.currentPage + 1 > data.length - 1
                            ? 0
                            : liquidController.currentPage + 1);
                  },
                  child: Text("Next", style: TextStyle(backgroundColor: Color(0xfff5f6fa)),),
                  color: Colors.white.withOpacity(0.01),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}

class WithPages extends StatefulWidget {
  static final style = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );

  @override
  _WithPages createState() => _WithPages();
}

class _WithPages extends State<WithPages> {
  int page = 0;
  var liquidController;
  var updateType;

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  final pages = [
    Container(
      color: Colors.pink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/1.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: <Widget>[
              Text(
                "Taj Mahal",
                style: WithPages.style,
              ),
              Text(
                "Location: Agra, Uttar Pradesh, India",
                style: WithPages.style,
              ),
              Text(
                "Architect: Ustad Ahmad Lahauri",
                style: WithPages.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.deepPurpleAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/2.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: <Widget>[
              Text(
                "Buckingham Palace",
                style: WithPages.style,
              ),
              Text(
                "Location: Westminster, London",
                style: WithPages.style,
              ),
              Text(
                "Architect: William Winde",
                style: WithPages.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.greenAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/3.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: <Widget>[
              Text(
                "Sydney Opera House",
                style: WithPages.style,
              ),
              Text(
                "Location: Bennelong Point, Sydney",
                style: WithPages.style,
              ),
              Text(
                "Architect: Jørn Utzon",
                style: WithPages.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.yellowAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/4.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: <Widget>[
              Text(
                "Leaning Tower of Pisa",
                style: WithPages.style,
              ),
              Text(
                "Location: Pisa, Italy",
                style: WithPages.style,
              ),
              Text(
                "Architect: Bonanno Pisano",
                style: WithPages.style,
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: Colors.redAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/5.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Column(
            children: <Widget>[
              Text(
                "Hagia Sophia",
                style: WithPages.style,
              ),
              Text(
                "Location: Fatih, Istanbul, Turkey",
                style: WithPages.style,
              ),
              Text(
                "Architect: Isidore of Miletus, Anthemius of Tralles",
                style: WithPages.style,
              ),
            ],
          ),
        ],
      ),
    ),
  ];

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: 25.0,
      child: new Center(
        child: new Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: new Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            LiquidSwipe(
              pages: pages,
              slideIconWidget: Icon(Icons.arrow_back_ios),
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              enableSideReveal: true,
              ignoreUserGestureWhileAnimating: true,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(pages.length, _buildDot),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: FlatButton(
                  onPressed: () {
                    liquidController.animateToPage(
                        page: pages.length - 1, duration: 700);
                  },
                  child: Text("Skip to End"),
                  color: Colors.white.withOpacity(0.01),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: FlatButton(
                  onPressed: () {
                    liquidController.jumpToPage(
                        page:
                        liquidController.currentPage + 1 > pages.length - 1
                            ? 0
                            : liquidController.currentPage + 1);
                  },
                  child: Text("Next"),
                  color: Colors.white.withOpacity(0.01),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}