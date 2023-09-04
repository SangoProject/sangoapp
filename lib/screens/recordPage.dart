import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';
import '../config/timer.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  GoogleMapController? _controller;
  Position? _currentPosition;
  bool isPaused = false; // 일시정지 상태 여부
  bool startRecording = false; // 기록중인 상태 여부
  int _seconds = 0;
  TimerUtil _timerUtil = TimerUtil();
  Stream<int> _timerStream = Stream<int>.empty();

  @override
  void dispose() {
    _timerUtil.stopTimer();
    super.dispose();
  }

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');

      setState(() {
        _currentPosition = position;
      });

      if (_controller != null) {
        _controller!.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(position.latitude, position.longitude),
            15.0, // Change zoom to 15.0 when getting current location
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  final List<Marker> markers = [];

  addMarker(cordinate) {
    int id = Random().nextInt(100);

    setState(() {
      markers.add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
    });
  }

  Stream<int> getTimerStream() {
    if (startRecording) {
      return _timerUtil.timerStream; // startRecording이 true일 때 타이머 스트림을 반환
    } else {
      return Stream<int>.empty(); // startRecording이 false일 때 빈 스트림을 반환
    }
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
                onTap: (cordinate) {
                  _controller?.animateCamera(CameraUpdate.newLatLng(cordinate));
                  addMarker(cordinate);
                },
                initialCameraPosition: _currentPosition != null
                    ? CameraPosition(
                  target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                  zoom: 15.0,
                )
                    : CameraPosition(
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          StreamBuilder<int>(
                            stream: getTimerStream(), // 조건에 따라 다른 스트림 반환
                            builder: (context, snapshot) {
                              final int seconds = snapshot.data ?? 0;
                              final String formattedTime = TimerUtil.getFormattedTime(seconds);
                              return Text(
                                formattedTime,
                                style: TextStyle(fontSize: 20),
                              );
                            },
                          ),
                          Text('0.0km',
                          style: TextStyle(fontSize: 20),),
                          TextButton(
                            onPressed: () {
                              getLocation();
                            },
                            child: Text('현위치'),
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ElevatedButton(
                            onPressed: !startRecording
                                ? null // 버튼을 비활성화 상태로 만듦
                                : () {
                              setState(() {
                                isPaused = !isPaused; // 버튼 상태 변경
                              });
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                Size(MediaQuery.of(context).size.width * 0.8, 50), // 가로 폭의 70%로 설정
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                startRecording ? Colors.white : Colors.grey, // 활성화 및 비활성화 상태의 색상 설정
                              ),
                            ),
                            child: Text(isPaused ? '이어하기' : '일시정지'), // 버튼 텍스트 동적으로 변경
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                startRecording = !startRecording;
                                if (startRecording) {
                                  _timerUtil.startTimer((seconds) {
                                    // 여기서 타이머 갱신된 값을 처리할 수 있습니다.
                                    // 예를 들어, 타이머 갱신된 값을 UI에 표시하거나 다른 작업을 수행할 수 있습니다.
                                  });
                                } else {
                                  _timerUtil.stopTimer();
                                }
                              });
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                Size(MediaQuery.of(context).size.width * 0.8, 50), // 가로 폭의 70%로 설정
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            ),
                            child: Text(startRecording ? '산책종료' : '산책시작'),
                          ),
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
