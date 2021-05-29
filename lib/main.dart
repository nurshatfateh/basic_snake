import 'dart:math';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
void main()
{
  return runApp(BasicSnake());
}
class BasicSnake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Homepage(),
    );
  }
}
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static List<int> pos=[104,105,106,107,108];
  int numberOfSquares=500;

  static var rand=Random();
  int food=rand.nextInt(500);
  void Food()
  {
    food=rand.nextInt(500);
  }
  void startGame()
  {


    pos=[104,105,106,107,108];
    const duration= const Duration(milliseconds:300);
    Timer.periodic(duration, (Timer timer) {
      updateSnake();
        if(gameOver())
          {
            timer.cancel();

          }
    });
  }
  var direction='right';
  void updateSnake()
  {
    setState(() {
      switch(direction)
      {
        case 'up':
          if(pos.last<20)
            {
              pos.add(pos.last-20+500);
            }
          else
            {
              pos.add(pos.last-20);
            }break;
        case 'down':
          if(pos.last>480)
          {
            pos.add(pos.last+20-500);
          }
          else
          {
            pos.add(pos.last+20);
          }break;
        case 'right':
          if((pos.last+1)%20==0)
          {
            pos.add(pos.last+1-20);
          }
          else
          {
            pos.add(pos.last+1);
          }break;
        case 'left':
          if(pos.last%20==0)
          {
            pos.add(pos.last-1+20);
          }
          else
          {
            pos.add(pos.last-1);
          }break;
        default:
      }
      if(pos.last==food)
        {
          Food();
        }
      else
        {
          pos.removeAt(0);
        }
    });
  }
  bool gameOver()
  {

    for(int i=0;i<pos.length;i++)
      {
        int count=0;
        for(int j=0;j<pos.length;j++)
          {
            if(pos[i]==pos[j])
              {
                count++;
              }
            if(count==2)
              {
                return true;
              }
          }
      }
    return false;
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Column(
        children: <Widget>[
          Expanded(
            child:GestureDetector(
              onVerticalDragUpdate:(details)
              {
                if(direction!='up'&&details.delta.dy>0)
                  {
                    direction='down';
                  }
                else if(direction!='down'&&details.delta.dy<0)
                  {
                    direction='up';
                  }
              },
              onHorizontalDragUpdate:(details)
              {
                if(direction!='left'&&details.delta.dx>0)
                {
                  direction='right';
                }
                else if(direction!='right'&&details.delta.dx<0)
                {
                  direction='left';
                }
              },
              child:Container(
                child:GridView.builder(
                  physics:NeverScrollableScrollPhysics(),
                  itemCount: numberOfSquares,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 20
                  ),
                  itemBuilder: (BuildContext context, int index)
                    {
                      if(pos.contains(index))
                        {
                          return Center(
                            child: Container(


                              padding: EdgeInsets.all(2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child:Container(
                                    color:Colors.white,
                                  ),
                                ),
                              ),
                            );
                        }
                      if(index==food)
                        {
                          return Container(
                            padding: EdgeInsets.all(2),
                            child:ClipRRect(
                              borderRadius:BorderRadius.circular(5),
                              child: Container(color: Colors.red)),
                          );
                        }
                      else
                        {
                          return Container(
                            padding:EdgeInsets.all(2),
                            child:ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child:Container(color: Colors.lightBlueAccent,)
                            ),
                          );}
                    }
                    
                ),
              color: Colors.lightBlue,),
            ),
          ),
          Padding(padding: const EdgeInsets.only(top: 30.0,bottom:50.0,left:20.0,right :20.0),
          child:Row
            (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:<Widget>[
              GestureDetector(
                onTap:startGame,
                child:Text('P L A Y !',style: TextStyle(color:Colors.red,fontSize:25,fontWeight: FontWeight.bold ),
                )),
            Text('S N A K E',style: TextStyle(color:Colors.grey,fontSize:25, fontWeight: FontWeight.bold ),
              )


            ],
          ),
        )
          
              ],
      ),
    );
  }
}
