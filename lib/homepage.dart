import 'dart:async';
import 'package:flutter/material.dart';
import 'package:game_flutter/button.dart';
import 'character.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'button.dart';
import 'barriers.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:audioplayers/audioplayers.dart';
class FrontScreen extends StatefulWidget {
  const FrontScreen({Key? key}) : super(key: key);

  @override
  _FrontScreenState createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  double cYaxis = 1.18;
  double cXaxis = -1;
  double initialHeight = 0;
  double time = 0;
  double height = 0;
  bool gameHasStarted = false;
  double barrierX = 0;
  double barrierXtwo = 0.5;
  double score = 0;
  final player = AudioCache();

  playSound()
  {
    player.play('assets_audios_jump.mp3');
  }
  void jump() {
    playSound();
    setState(() {
      time = 0;
      initialHeight = cYaxis;
    });
  }

  void startGame() {
    playSound();
    jump();
    gameHasStarted = true;
    initialHeight = cYaxis;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.5 * time;
      setState(() {
        cYaxis = initialHeight - height;
      });
      setState(() {
        if(cYaxis <= -1)
          {
            timer.cancel();
            Alert(context: context, title: "Game Over", desc: "Your Score:$score").show();
             cYaxis = 1.2;
             cXaxis = -1;
             initialHeight = 0;
             time = 0;
             height = 0;
             gameHasStarted = false;
             barrierX = 0;
             barrierXtwo = 0.5;
             score = 0;
          }
      });
      setState(() {
        if(cYaxis > 0.80 && cXaxis > barrierX)
          {
            timer.cancel();
            Alert(context: context, title: "Game Over", desc: "Your Score:$score").show();
            cYaxis = 1.2;
            cXaxis = -1;
            initialHeight = 0;
            time = 0;
            height = 0;
            gameHasStarted = false;
            barrierX = 0;
            barrierXtwo = 0.5;
            score = 0;
          }
        else
          {
            score++;
          }
      });
      setState(() {
        if(cYaxis > 0.80 && cXaxis > barrierXtwo)
        {
          timer.cancel();
          Alert(context: context, title: "Game Over", desc: "Your Score:$score").show();
          cYaxis = 1.2;
          cXaxis = -1;
          initialHeight = 0;
          time = 0;
          height = 0;
          gameHasStarted = false;
          barrierX = 0;
          barrierXtwo = 0.5;
          score = 0;
        }
        else
          {
            score++;
          }
      });
      setState(() {
        if(barrierX < -1.00)
          {
            barrierX += 1.5;
          }
        else
          {
            barrierX -= 0.05;
          }
      });
      setState(() {
        if(barrierXtwo < -1.0)
        {
          barrierXtwo += 1.5;
        }
        else
        {
          barrierXtwo -= 0.05;
        }
      });
      if(cYaxis >= 1.08)
      {
        setState(() {
          cYaxis = 1.08;
        });
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
               flex: 5,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('SCORE:',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                      Text(score.toString(),style: const TextStyle(fontSize: 40,fontWeight: FontWeight.bold),)
                    ],
                  ),
              color: Colors.grey,
            )),
            Expanded(
              flex: 2,
              child: Stack(
                  children: [
                AnimatedContainer(
                  alignment: Alignment(cXaxis, cYaxis),
                  duration: const Duration(milliseconds: 0),
                  child: const Character(),
                ),
                AnimatedContainer(
                    duration: const Duration(milliseconds: 0),
                    alignment:Alignment(barrierX,1),
                    child: const MyBarrier(
                      size: 50.0,
                    )),
                AnimatedContainer(
                    duration: const Duration(milliseconds: 0),
                    alignment:Alignment(barrierXtwo,1),
                    child: const MyBarrier(
                      size: 50.0,
                    ))
              ]),
            ),
            const SizedBox(
              height: 20,
              child: DecoratedBox(decoration: BoxDecoration(
                color: Colors.green,
              )),
            ),
            Expanded(
                child: MyButton(
                  child: const Icon(
                    FontAwesomeIcons.arrowUp,
                    color: Colors.white,
                  ),
                  function: gameHasStarted == false?startGame:jump,
                ))
          ],
        ),
      ),
    );
  }
}
