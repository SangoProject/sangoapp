import 'package:flutter/material.dart';
import 'package:sangoproject/screens/searchResultPage.dart';

class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage>{
  List<String> dropdownList = ['가나다', '라마바', '사아자'];
  String dropdownValue = '가나다';
  List<bool> _selections1 = List.generate(3, (index) => false);
  List<bool> _selections2 = List.generate(3, (index) => false);
  List<bool> _selections3 = List.generate(3, (index) => false);

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
          Row(
            children: <Widget>[
              SizedBox(width: 15,),
              Text('서울특별시', style: TextStyle(fontSize: 15)),
              SizedBox(width: 15,),
              DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String? newValue){
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: dropdownList.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ToggleButtons(
                children: <Widget>[
                  Text("  30분 이하  "),
                  Text("  1시간 이하  "),
                  Text("  2시간 초과  "),
                ],
                onPressed: (int index){
                  setState(() {
                    _selections1[index] = !_selections1[index];
                  });
                },
                isSelected: _selections1,
              )
            ],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ToggleButtons(
                children: <Widget>[
                  Text("  1km 이하  "),
                  Text("  5km 이하  "),
                  Text("  10km 초과  "),
                ],
                onPressed: (int index){
                  setState(() {
                    _selections2[index] = !_selections2[index];
                  });
                },
                isSelected: _selections2,
              )
            ],
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ToggleButtons(
                children: <Widget>[
                  Text("   상   "),
                  Text("   중   "),
                  Text("   하   "),
                ],
                onPressed: (int index){
                  setState(() {
                    _selections3[index] = !_selections3[index];
                  });
                },
                isSelected: _selections3,
              )
            ],
          ),

          SizedBox(height: 18,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SearchResultPage()));
                  },
                  child: Text('검색하기')
              ),
            ],
          ),
        ],
      ),
    );
  }
}