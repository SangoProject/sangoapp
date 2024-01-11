// 산책코스를 위치, 시간, 거리, 난이도에 따라 필터링 하는 역할
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sangoproject/screens/search/searchResultPage.dart';
import '../../config/palette.dart';

class SearchPage extends StatefulWidget{
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState(){
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage>{
  // 검색 항목 중 위치 정보 리스트
  List<String> areaGu = [
    '강남구', '강동구', '강북구', '강서구', '관악구',
    '광진구', '구로구', '금천구', '노원구', '도봉구',
    '동대문구', '동작구', '마포구', '서대문구', '서초구',
    '성동구', '성북구', '송파구', '양천구', '영등포구',
    '용산구', '은평구', '종로구', '중구', '중랑구'
  ];
  String dropdownValue = '강남구'; // 초기 위치 값
  final List<bool> _leadTime = List.generate(3, (index) => false); // 소요시간 선택 여부에 따른 bool값
  final List<bool> _distance = List.generate(3, (index) => false); // 산책거리 선택 여부에 따른 bool값
  final List<bool> _courseLevel = List.generate(3, (index) => false); // 난이도 선택 여부에 따른 bool값

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '산책로 검색',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 위치 선택 UI
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                        // 위치 정보 리스트 중 선택한 값으로 변경함.
                        onChanged: (String? newValue){
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        // 위치를 dropdownmenu로 보여줌.
                        items: areaGu.map<DropdownMenuItem<String>>((String value){
                          return DropdownMenuItem<String>(
                            // 선택된 위치 정보로 값이 보여짐.
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 산책시간 UI
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      '산책 시간',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ToggleButtons(
                          // 버튼을 누르면 산책시간 선택 여부를 토글해 줌.
                          onPressed: (int index){
                            setState(() {
                              _leadTime[index] = !_leadTime[index];
                            });
                          },
                          isSelected: _leadTime,
                          // 산책시간 선택지
                          children: const <Widget>[
                            Text("  1시간 이하  "),
                            Text("  1시간 초과 ~ 2시간 이하  "),
                            Text("  2시간 초과  "),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 산책거리 UI
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      '산책 거리',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ToggleButtons(
                          // 버튼을 누르면 산책거리 선택 여부를 토글해 줌.
                          onPressed: (int index){
                            setState(() {
                              _distance[index] = !_distance[index];
                            });
                          },
                          isSelected: _distance,
                          // 산책 거리 선택지
                          children: const <Widget>[
                            Text("  1km 이하  "),
                            Text("  1km 초과 ~ 5km 이하  "),
                            Text("  5km 초과  "),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 난이도 UI
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      '난이도',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ToggleButtons(
                          // 버튼을 누르면 난이도 선택 여부를 토글해 줌.
                          onPressed: (int index){
                            setState(() {
                              _courseLevel[index] = !_courseLevel[index];
                            });
                          },
                          isSelected: _courseLevel,
                          // 난이도 선택지
                          children: const <Widget>[
                            Text("     상     "),
                            Text("     중     "),
                            Text("     하     "),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18,),

            // 검색 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () async {
                      // 집합 형식으로 필터링해줌.
                      // 산책코스 데이터 전체를 불러옴.
                      final realtimeDB = await FirebaseDatabase.instance.ref('SEARCH').child(dropdownValue).once();
                      final List<dynamic> data = realtimeDB.snapshot.value as List<dynamic>;
                      // 가져온 데이터를 집합형식으로 바꾸어 줌.
                      Set<dynamic> searchData = data.toSet();

                      //산책시간 필터링
                      if(_leadTime[0] || _leadTime[1] || _leadTime[2]){
                        Set<dynamic> _dataLeadTime = {};
                        for(dynamic i in data){
                          if(_leadTime[0]){
                            if(i["lead_time"] <= 60){
                              _dataLeadTime.add(i);
                              continue;
                            }
                          }
                          if(_leadTime[1]){
                            if(i["lead_time"] > 60 && i["lead_time"] <= 120){
                              _dataLeadTime.add(i);
                              continue;
                            }
                          }
                          if(_leadTime[2]){
                            if(i["lead_time"] > 120){
                              _dataLeadTime.add(i);
                              continue;
                            }
                          }
                        }
                        // 필터링된 산책시간과 전체 데이터의 교집합을 저장함.
                        searchData = searchData.intersection(_dataLeadTime);
                      }

                      //산책 거리 필터링
                      if(_distance[0] || _distance[1] || _distance[2]){
                        Set<dynamic> _dataDistance = {};
                        for(dynamic i in data){
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
                        // 필터링된 산책거리와 남은 데이터의 교집합을 저장함.
                        searchData = searchData.intersection(_dataDistance);
                      }

                      //난이도 필터링
                      if(_courseLevel[0] || _courseLevel[1] || _courseLevel[2]){
                        Set<dynamic> _dataLevel = {};
                        for(dynamic i in data){
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
                        // 필터링된 난이도와 남은 데이터의 교집합을 저장함.
                        searchData = searchData.intersection(_dataLevel);
                      }

                      // 검색 결과 페이지로 넘어감.
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SearchResultPage(dropdownValue, searchData.toList()))
                      );
                    },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Palette.logoColor, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.search),
                      SizedBox(width: 8), // Add some spacing between icon and text
                      Text('검색',
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}