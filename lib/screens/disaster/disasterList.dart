// 재난 정보를 리스트로 보여주는 위젯
import 'package:flutter/material.dart';
import 'package:sangoproject/screens/disaster/disasterMsg.dart';
import 'package:sangoproject/screens/disaster/disasterMsgRepository.dart';

class DisasterListPage extends StatelessWidget {
  DisasterListPage({super.key});
  final DisasterRepository _disasterRepository = DisasterRepository();

  // 재난 정보 한 개에 해당하는 UI
  Widget _makeMsgOne(DisasterMsg disasterMsg) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 일시를 보여줌.
                Text(
                  "${disasterMsg.create_date}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                // 메시지 내용을 보여줌.
                Text(
                  disasterMsg.msg.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                  fontFamily: 'Choi'),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '재난 알림 목록',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder(
          // 재난정보를 불러옴.
          future: _disasterRepository.loadDisaster(),
          builder: (context, AsyncSnapshot<List<DisasterMsg>?> snapshot) {
            // 값을 불러오지 못 한다면 CircularProgressIndicator를 화면에 띄움.
            if (snapshot.hasData == false) {
              return CircularProgressIndicator();
            }

            // 가져온 데이터 중 msg에 '찾습니다'가 들어간 데이터는 제외함.
            List<DisasterMsg> filteredMessages = snapshot.data!
                .where((msg) => !msg.msg!.contains('찾습니다'))
                .toList();

            return Column(
              children: [
                Expanded(
                  // 재난 정보를(_makeMsgOne 위젯) 리스트로 만듦.
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: filteredMessages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white, // 하얀 배경
                            borderRadius: BorderRadius.circular(8), // 약간의 BorderRadius
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5), // 그림자 색상 및 투명도
                                spreadRadius: 2, // 그림자 확장 범위
                                blurRadius: 5, // 그림자 흐림 범위
                                offset: Offset(0, 3), // 그림자 위치 (x, y)
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _makeMsgOne(filteredMessages[index]),
                          ),
                        );
                      }
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}