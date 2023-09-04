import 'package:flutter/material.dart';
import 'package:sangoproject/screens/course_data/courseInfo.dart';
import 'package:sangoproject/screens/searchResultPage.dart';
import 'package:firebase_database/firebase_database.dart';

class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage>{
  List<String> dropdownList = [
    '강남구', '강동구', '강북구', '강서구', '관악구',
    '광진구', '구로구', '금천구', '노원구', '도봉구',
    '동대문구', '동작구', '마포구', '서대문구', '서초구',
    '성동구', '성북구', '송파구', '양천구', '영등포구',
    '용산구', '은평구', '종로구', '중구', '중랑구'
  ];
  String dropdownValue = '강남구';
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
                  onPressed: () async {
                    final tmp = await FirebaseDatabase.instance.ref('DATA').orderByChild('area_gu').equalTo(dropdownValue);
                    tmp.onValue.listen((DatabaseEvent event){
                      //관악구
                      //List<dynamic> _data = event.snapshot.value as List<dynamic>;
                      Map<dynamic, dynamic> _toMap = event.snapshot.value as Map<dynamic, dynamic>;
                      List<CourseInfo> _data = _toMap.values.map((e) => CourseInfo.fromJson(e)).toList();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SearchResultPage(dropdownValue, _data))
                      );
                    });
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