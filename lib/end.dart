import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EndPage extends StatelessWidget {
  final bool win;
  final Stopwatch stopwatch;
  EndPage(this.win,this.stopwatch);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Color(0xFFFFD9CE),
      body: Column(
        children: <Widget>[
          Expanded(child: SizedBox()),
          Center(
            child: Container(
              height: 50,
              child: win
                  ? Text(
                      'Hai completato il livello',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : Text(
                      'Hai sbagliato a completare il livello',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Icon(
            win ? Icons.done : Icons.close,
            size: 256,
            color: Colors.white,
          ),
          Text(
                      'Ci hai messo ${(stopwatch.elapsedMilliseconds/1000).toStringAsFixed(0)} secondi',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
