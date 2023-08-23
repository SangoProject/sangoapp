import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sangoproject/config/palette.dart';
import 'dart:math';

class RecordPage extends StatefulWidget{
  const RecordPage({Key? key}) : super(key: key);

  @override
  _RecordPageState createState() => _RecordPageState();
}

  class _RecordPageState extends State<RecordPage> {
    // 애플리케이션에서 지도를 이동하기 위한 컨트롤러
    late GoogleMapController _controller;

    // 이 값은 지도가 시작될 때 첫 번째 위치입니다.
    final CameraPosition _initialPosition =
    CameraPosition(target: LatLng(41.017901, 28.847953));

    // 지도 클릭 시 표시할 장소에 대한 마커 목록
    final List<Marker> markers = [];

    addMarker(cordinate) {
      int id = Random().nextInt(100);

      setState(() {
        markers
            .add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
      });
    }

    final LatLng _center = const LatLng(37.541, 126.986);

// class _RecordPageState extends State<RecordPage> {
//   late GoogleMapController _controller;
//
//   final LatLng _center = const LatLng(37.541, 126.986);
//
//   // void _onMapCreated(GoogleMapController controller) {
//   //   GoogleMapController = controller;
//   // }
//   // 지도 클릭 시 표시할 장소에 대한 마커 목록
//   final List<Marker> markers = [];
//
//   addMarker(cordinate) {
//     int id = Random().nextInt(100);
//
//     setState(() {
//       markers
//           .add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
//     });

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // appBar: AppBar(
          //   title: const Text('record page'),
          //   backgroundColor: Colors.lime,
          // ),
          body: Column(
            children: [
              SizedBox(
                height: 500,
                child: GoogleMap(
                  onMapCreated: (controller) {
                    setState(() {
                      _controller = controller;
                    });
                  },
                  markers: markers.toSet(),

                  // 클릭한 위치가 중앙에 표시
                  onTap: (cordinate) {
                    _controller.animateCamera(
                        CameraUpdate.newLatLng(cordinate));
                    addMarker(cordinate);
                  },
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 200,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text('산책 시간 15분'),
                      Text('산책 거리 1km'),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // 첫 번째 버튼이 눌렸을 때 실행할 코드
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white, // 테두리 색상
                          ),
                          child: Text('일시정지'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // 두 번째 버튼이 눌렸을 때 실행할 코드
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                          ),
                          child: Text('산책종료'),
                        ),
                      ],
                ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }