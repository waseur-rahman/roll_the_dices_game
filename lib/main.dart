import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: DiceGame(),
    );
  }
}

class DiceGame extends StatefulWidget {
  @override
  _DiceGameState createState() => _DiceGameState();
}

class _DiceGameState extends State<DiceGame> {
  var random = Random.secure();
  var dices = const <String>[
    'images/d1.png',
    'images/d2.png',
    'images/d3.png',
    'images/d4.png',
    'images/d5.png',
    'images/d6.png'
  ];
  var index1 = 0;
  var index2 = 0;
  var score = 0;
  var highestScore = 0;
  var started = false;
  var hitTheRoll = false;
  var newHighest = 0;

  void _rollDice() {
    setState(() {
      index1 = random.nextInt(6);
      index2 = random.nextInt(6);
      score += index1 + index2 + 2;
//      highestScore += index1 + index2 + 2;

      if (highestScore < score) {
        highestScore = score;

        if (highestScore < newHighest) {
          highestScore = newHighest;
        }
      }
    });
  }

  void _replayGame() {
    setState(() {
      score = 0;
      index1 = 0;
      index2 = 0;
      //highestScore = 0;
    });
  }

  void _resetGame() {
    setState(() {
      score = 0;
      index1 = 0;
      index2 = 0;
      highestScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //  appBar: AppBar(
        // title: Text('Dice Game'),
        // ),
        body: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 25, left: 8, bottom: 30, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (started)
                      Text(
                        'Score: $score',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    if (started || index1 + index2 + 2 == 7)
                      Text(
                        'Highest Score:  $highestScore',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (index1 + index2 + 2 == 7)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "7 Not Always Lucky!",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: Colors.lightBlue,
                            ),
                          ),
                          Image.asset(
                            'images/emoji.png',
                            width: 35,
                            height: 35,
                          )
                        ],
                      ),
                    SizedBox(
                      height: 30,
                    ),
                    if (!started)
                      Center(
                        child: Text(
                          'Roll The Dices',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    if (!started)
                      Image.asset(
                        'images/first.gif',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    if (started & hitTheRoll)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            dices[index1],
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            dices[index2],
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (started && (index1 + index2 + 2 != 7))
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                started = true;
                                hitTheRoll = true;
                                _rollDice();
                              });
                            },
                            child: Text('Roll Dice'),
                          ),
                        if (!started)
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  started = true;
                                });
                              },
                              child: Text('Play')),
                      ],
                    ),
                    if (index1 + index2 + 2 == 7)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Game Over',
                            style: TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.w800,
                              color: Colors.lightBlue,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          if (index1 + index2 + 2 == 7)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      _replayGame();
                                    });
                                  },
                                  icon: Icon(
                                    Icons.play_arrow,
                                  ),
                                  label: Text('Play Again'),
                                ),
                                SizedBox(
                                  width: 0,
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      _resetGame();
                                    });
                                  },
                                  icon: Icon(
                                    Icons.replay_outlined,
                                  ),
                                  label: Text('Reset'),
                                ),
                              ],
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
