import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

import 'package:permission_handler/permission_handler.dart';
import 'package:sangoproject/config/location.dart';

class RecordPage extends StatefulWidget{
  const RecordPage({Key? key}) : super(key: key);

  @override
  _RecordPageState createState() => _RecordPageState();
}

  class _RecordPageState extends State<RecordPage> {
    // 애플리케이션에서 지도를 이동하기 위한 컨트롤러
    GoogleMapController? _controller;
    Position? _currentPosition;

    @override
    void initState() {
      super.initState();
      // _checkLocationPermission();
      // _getCurrentLocation();
    }

    // Future<void> _getCurrentLocation() async {
    //   final position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high,
    //   );
    //
    //   setState(() {
    //     _currentPosition = position;
    //   });
    // }
    // void _onMapCreated(GoogleMapController controller) {
    //   _controller = controller;
    // }

    // Future<void> _checkLocationPermission() async {
    //   final status = await Permission.location.request();
    //   if (status.isGranted) {
    //     print('Location permission granted');
    //   } else {
    //     print('Location permission denied');
    //   }
    // }

    // 지도 클릭 시 표시할 장소에 대한 마커 목록
    final List<Marker> markers = [];

    addMarker(cordinate) {
      int id = Random().nextInt(100);

      setState(() {
        markers
            .add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
      });
    }

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
                    _controller?.animateCamera(
                        CameraUpdate.newLatLng(cordinate));
                    addMarker(cordinate);
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(37.541, 126.986),
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
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('산책 시간 15분'),
                            Text('산책 거리 1.0km'),
                            TextButton(
                              onPressed: () {
                                getLocation();
                                // print('Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}');
                                // 현위치를 반환하는 버튼
                                // _controller?.animateCamera(
                                //   CameraUpdate.newLatLng(
                                //     LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                                //   ),
                                // );
                              }, child: Text('현위치'),
                            )
                          ]
                      ),
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