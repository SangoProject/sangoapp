import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/goalGraph.dart';
import 'goal_data/pie_edit.dart';

class GoalPage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '오늘의 목표',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PieDataScreen()),
                    );
                  },
                  icon: Image.asset('images/pencil.png'),
                ),
              ],
            ),
          ),
          ChartPage(),
        ],
      ),
    );
  }
}