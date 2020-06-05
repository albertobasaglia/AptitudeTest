import 'package:draganddrop/end.dart';
import 'package:draganddrop/rect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'drawShape.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Test your skills'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Stopwatch stopwatch;

  void _restart() {
    setState(() {
      up.removeRange(0, 3);
      up.addAll([null, null, null]);
    });
  }

  void _newGame() {
    down.shuffle();
  }

  void _confirm() {
    bool win = up[0] != null &&
        up[1] != null &&
        up[2] != null &&
        up[0].pos == 0 &&
        up[1].pos == 1 &&
        up[2].pos == 2;
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => EndPage(win, stopwatch),
      ),
    )
        .then((d) {
      stopwatch.reset();
      stopwatch.start();
    });
    Future.delayed(Duration(milliseconds: 300)).then((d) {
      _newGame();
      _restart();
    });
  }

  Color box = Color(0xff538083);

  List<Rect> down = List();
  List<Rect> up = List();

  _MyHomePageState() {
    stopwatch = Stopwatch();
    stopwatch.start();
    down.addAll([
      Rect(50, 0),
      Rect(70, 1),
      Rect(90, 2),
    ]);
    up.addAll([null, null, null]);
    down.shuffle();
  }

  Container getBox(double size, Color color) {
    return Container(
      height: size,
      width: size,
      decoration: (color != null)
          ? BoxDecoration(
              color: box,
            )
          : null,
    );
  }

  Draggable getDraggableBox(Rect rect) {
    double size = rect.size;
    return Draggable<Rect>(
      data: rect,
      child: getBox(size, box),
      feedback: getBox(size, box),
      childWhenDragging: getBox(size, null),
    );
  }

  Expanded getDragTarget(int index) {
    return Expanded(
      child: Container(
        height: 300,
        width: 100,
        child: DragTarget<Rect>(
          builder: (context, data, boh) {
            return up[index] != null
                ? Column(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(),
                      ),
                      getBox(up[index].size, box),
                      SizedBox(
                        height: 4,
                      )
                    ],
                  )
                : null;
          },
          onWillAccept: (data) => true,
          onAccept: (data) {
            setState(() {
              up[index] = data;
            });
          },
        ),
      ),
    );
  }

  Color buttonColor1 = Color(0xFF2A7F62);
  Color buttonColor2 = Color(0xFFF8C7CC);
  //https://coolors.co/c3acce-ffd9ce-89909f-538083-2a7f62
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFD9CE),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                height: 200,
                width: 300,
                child: Stack(
                  children: <Widget>[
                    CustomPaint(
                      size: Size.fromHeight(200),
                      painter: DrawShape(),
                    ),
                    Row(
                      children: <Widget>[
                        getDragTarget(0),
                        getDragTarget(1),
                        getDragTarget(2),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(color: Color(0xff89909F)),
                height: 200,
                //width: 350,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 65,
                    ),
                    up.contains(down[0])
                        ? SizedBox(width: down[0].size)
                        : getDraggableBox(down[0]),
                    SizedBox(
                      width: 25,
                    ),
                    up.contains(down[1])
                        ? SizedBox(width: down[1].size)
                        : getDraggableBox(down[1]),
                    SizedBox(
                      width: 25,
                    ),
                    up.contains(down[2])
                        ? SizedBox(width: down[2].size)
                        : getDraggableBox(down[2]),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                height: 100,
                width: 325,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        _restart();
                      },
                      child: Container(
                        width: 150,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: buttonColor2,
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Center(
                          child: Text(
                            'RICOMINCIA',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        _confirm();
                      },
                      child: Container(
                        width: 150,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: buttonColor1,
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Center(
                          child: Text(
                            'CONFERMA',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
