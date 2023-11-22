import 'package:flutter/material.dart';
import 'package:sangoproject/screens/disaster/disasterMsg.dart';
import 'package:sangoproject/screens/disaster/disasterMsgRepository.dart';

class DisasterListPage extends StatelessWidget {
  DisasterListPage({super.key});
  final DisasterRepository _disasterRepository = DisasterRepository();

  Widget _makeMsgOne(DisasterMsg disasterMsg) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "일시 : ${disasterMsg.create_date}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "위치 : ${disasterMsg.location_name}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  disasterMsg.msg.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
          future: _disasterRepository.loadDisaster(),
          builder: (context, AsyncSnapshot<List<DisasterMsg>?> snapshot) {
            if (snapshot.hasData == false) {
              return CircularProgressIndicator();
            }

            List<DisasterMsg> filteredMessages = snapshot.data!
                .where((msg) => !msg.msg!.contains('찾습니다'))
                .toList();

            return Expanded(
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
            );
          },
        ),
      ),
    );
  }
}
/*class DisasterListPage extends StatelessWidget {
  const DisasterListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerheight = MediaQuery.of(context).size.height;
    final bannerwidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(
          '재난 문자 공지',
          style: TextStyle(
            fontSize: 20,
            ),
          ),
        ),
        body: Container(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 15,
              itemBuilder: (context, index) {
                return Container(
                  width: bannerwidth,
                  height: bannerheight / 8,
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
                    child: Text(
                      'Item $index 재난 상황입니다. 이건 실제 상황이니 긴급히 대피하시기 바랍니다',
                      style: TextStyle(
                        color: Colors.black, // 텍스트 색상 설정
                      ),
                    ),
                  ),
                );
              }
          ),
        )
    );
  }
}*/
