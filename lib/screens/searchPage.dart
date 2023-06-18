import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('검색'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //위치
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Text(
              '위치',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: '검색할 지역을 입력해주세요.',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          //산책시간
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Text(
              '산책 시간',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //산책거리
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Text(
              '산책 거리',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //난이도
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Text(
              '난이도',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                  onPressed: (){},
                  child: Text('하')
              ),
              ElevatedButton(
                  onPressed: (){},
                  child: Text('중')
              ),
              ElevatedButton(
                  onPressed: (){},
                  child: Text('상')
              ),
            ],
          ),
        ],
      ),
    );
  }
}