import 'package:flutter/material.dart';

class DisasterListPage extends StatelessWidget {
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
              scrollDirection: Axis.vertical, // 스크롤 방향을 가로로 설정
              itemCount: 15, // 10개의 아이템을 만듭니다
              itemBuilder: (context, index) {
                // 각 아이템은 정사각형 모양의 컨테이너입니다
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
}
