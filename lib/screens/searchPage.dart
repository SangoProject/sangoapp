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
  List<String> areaGu = [
    '강남구', '강동구', '강북구', '강서구', '관악구',
    '광진구', '구로구', '금천구', '노원구', '도봉구',
    '동대문구', '동작구', '마포구', '서대문구', '서초구',
    '성동구', '성북구', '송파구', '양천구', '영등포구',
    '용산구', '은평구', '종로구', '중구', '중랑구'
  ];
  String dropdownValue = '강남구';
  List<bool> _leadTime = List.generate(3, (index) => false);
  List<bool> _distance = List.generate(3, (index) => false);
  List<bool> _courseLevel = List.generate(3, (index) => false);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '검색',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
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
                items: areaGu.map<DropdownMenuItem<String>>((String value){
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
                  Text("  1시간 이하  "),
                  Text("  1시간 초과 2시간 이하  "),
                  Text("  2시간 초과  "),
                ],
                onPressed: (int index){
                  setState(() {
                    _leadTime[index] = !_leadTime[index];
                  });
                },
                isSelected: _leadTime,
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
                  Text("  1km 초과  5km 이하  "),
                  Text("  5km 초과  "),
                ],
                onPressed: (int index){
                  setState(() {
                    _distance[index] = !_distance[index];
                  });
                },
                isSelected: _distance,
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
                    _courseLevel[index] = !_courseLevel[index];
                  });
                },
                isSelected: _courseLevel,
              )
            ],
          ),

          SizedBox(height: 18,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () async {
                    // 데이터 가져오기
                    final tmp = await FirebaseDatabase.instance.ref('SEARCH').child(dropdownValue);
                    tmp.onValue.listen((DatabaseEvent event){
                      List<dynamic> _list = event.snapshot.value as List<dynamic>;
                      Set<dynamic> _data = _list.toSet();
                      //산책 시간 필터링
                      if(_leadTime[0] || _leadTime[1] || _leadTime[2]){
                        Set<dynamic> _dataLeadTime = {};
                        for(dynamic i in _list){
                          if(_leadTime[0]){
                            if(i["lead_time"] <= 30){
                              _dataLeadTime.add(i);
                              continue;
                            }
                          }
                          if(_leadTime[1]){
                            if(i["lead_time"] > 30 && i["lead_time"] <= 60){
                              _dataLeadTime.add(i);
                              continue;
                            }
                          }
                          if(_leadTime[2]){
                            if(i["lead_time"] > 60){
                              _dataLeadTime.add(i);
                              continue;
                            }
                          }
                        }
                        _data = _data.intersection(_dataLeadTime);
                      }
                      //산책 거리 필터링
                      if(_distance[0] || _distance[1] || _distance[2]){
                        Set<dynamic> _dataDistance = {};
                        for(dynamic i in _list){
                          if(_distance[0]){
                            if(i["distance"] <= 1.0){
                              _dataDistance.add(i);
                              continue;
                            }
                          }
                          if(_distance[1]){
                            if(i["distance"] > 1.0 && i["distance"] <= 5.0){
                              _dataDistance.add(i);
                              continue;
                            }
                          }
                          if(_distance[2]){
                            if(i["distance"] > 5.0){
                              _dataDistance.add(i);
                              continue;
                            }
                          }
                        }
                        _data = _data.intersection(_dataDistance);
                      }
                      //난이도 필터링
                      if(_courseLevel[0] || _courseLevel[1] || _courseLevel[2]){
                        Set<dynamic> _dataLevel = {};
                        for(dynamic i in _list){
                          if(_courseLevel[0]){
                            if(i["course_level"] == 3){
                              _dataLevel.add(i);
                              continue;
                            }
                          }
                          if(_courseLevel[1]){
                            if(i["course_level"] == 2){
                              _dataLevel.add(i);
                              continue;
                            }
                          }
                          if(_courseLevel[2]){
                            if(i["course_level"] == 1){
                              _dataLevel.add(i);
                              continue;
                            }
                          }
                        }
                        _data = _data.intersection(_dataLevel);
                      }
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SearchResultPage(dropdownValue, _data.toList()))
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