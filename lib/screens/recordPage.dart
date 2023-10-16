import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';
import '../config/palette.dart';
import '../config/timer.dart';
import 'components/popDialog.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  GoogleMapController? _controller;
  Position? _currentPosition;
  bool isRecording = false; // 기록중인 상태 여부
  final TimerUtil _timerUtil = TimerUtil();
  final StreamController<int> _timerStreamController = StreamController<int>();
  double distanceInMeters = 0.0; // 순간 이동 거리
  double distanceTotal = 0.0; // 총 이동 거리

  final List<LatLng> _polylineCoordinates = [];
  late Polyline _polyline;
  final Set<Polyline> _polylines = {};

  @override
  void dispose() {
    if (_locationUpdateTimer != null && _locationUpdateTimer!.isActive) {
      _locationUpdateTimer?.cancel();
    }
    _timerStreamController.close();
    super.dispose();
  }

  Timer? _locationUpdateTimer;

  void startLocationUpdates() {
    if (_locationUpdateTimer == null || !_locationUpdateTimer!.isActive) {
      _locationUpdateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        getLocation();
      });
    }
  }

  void stopLocationUpdates() {
    if (_locationUpdateTimer != null && _locationUpdateTimer!.isActive) {
      _locationUpdateTimer!.cancel();
    }
  }

  // 지도 초기화 or 현위치 버튼 누를시 현재 위치 가져오는 비동기 메서드
  Future<Position> _getInitialLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (_controller != null) {
        _controller!.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(position.latitude, position.longitude),
            18.0, // 줌 값 변경
          ),
        );
      }
      return position;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  // 주기적으로 위치 업데이트 가져오는 비동기 메서드
  Future<void> getLocation() async {
    if (mounted) {
      try {
        Position newPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        // 이전 위치가 null이면 새 위치를 현재 위치로 설정
        _currentPosition ??= newPosition;

        // 새 위치와 이전 위치의 거리를 계산
        double distanceInMeters = Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          newPosition.latitude,
          newPosition.longitude,
        );

        // 위치가 변경된 경우에만 처리
        if (distanceInMeters > 0.0) {
          // Polyline에 새 위치 추가
          _polylineCoordinates.add(LatLng(newPosition.latitude, newPosition.longitude));

          // Polyline 업데이트
          setState(() {
            _currentPosition = newPosition;
          });
          if (isRecording == true) {
            distanceTotal += distanceInMeters; // 총 이동 거리
            print('Distance: $distanceInMeters meters');
            print('Current Position: ${newPosition.latitude}, ${newPosition.longitude}');
          }
        }
      } catch (e) {
        print('Error in getLocation: $e');
      }
    }
  }

  void updateMap(Position currentPosition) {
    DateTime now = DateTime.now();
    String polylineId = 'polyline_${now.year}${now.month}${now.day}_${now.hour}${now.minute}${now.second}';

    if (_controller != null) {
      _controller!.animateCamera(
        CameraUpdate.newLatLng(
            LatLng(currentPosition.latitude, currentPosition.longitude)
        ),
      );
      _polyline = Polyline(
        polylineId: PolylineId(polylineId),
        points: _polylineCoordinates,
        color: Colors.blue,
        width: 5,
      );
      _polylines.add(_polyline);
    } else {
      _polyline = _polylineCoordinates as Polyline;
    }
  }

  final _markers = <Marker>{};

  addMarker(LatLng coordinate) {
    final int id = Random().nextInt(100);

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(id.toString()),
          position: coordinate,
        ),
      );
      print('Marker added at $coordinate');
    });
  }

  Stream<int> getTimerStream() {
    if (isRecording) {
      return _timerUtil.timerStream;
    } else {
      return Stream<int>.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Position>(
        future: _getInitialLocation(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _currentPosition = snapshot.data!;
            return buildMap();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildMap() {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: GoogleMap(
            onMapCreated: (controller) {
              setState(() {
                _controller = controller;
              });
            },
            onTap: (cordinate) {
              _controller?.animateCamera(CameraUpdate.newLatLng(cordinate));
             },
            initialCameraPosition: CameraPosition(
              target: LatLng(_currentPosition?.latitude ?? 37.541, _currentPosition?.longitude ?? 126.986),
              zoom: 18.0,
              // bearing: _currentPosition!.heading,
            ),
            compassEnabled: true,
            myLocationEnabled: true,
            markers: _markers,
            polylines: _polylines,
          ),
        ),
        // Add other widgets here
        Expanded(
          child: Container(
            padding: EdgeInsets.all(24.0),
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0), // 둥근 모서리 설정
              border: Border.all(width: 1.0, color: Palette.logoColor),
            ),
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
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                      Text('${(distanceTotal/1000).toStringAsFixed(2)} km', // 미터를 킬로미터로 변환
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      TextButton(
                        onPressed: () {
                          getLocation();
                        },
                        child: Text('현위치', style: TextStyle(fontSize: 16),),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (!isRecording) {
                                _timerUtil.resetTimer(); // 타이머 초기화
                                _polylineCoordinates.clear(); // polyline 초기화
                                stopLocationUpdates();
                              }
                              isRecording = !isRecording;
                              if (isRecording) {
                                // 위치 가져오고 마커 추가
                                Timer.periodic(Duration(seconds: 1), (timer) {
                                  getLocation().then((position) {
                                    if (mounted) {
                                      if (_currentPosition != null && _currentPosition!.latitude != 0 && _currentPosition!.longitude != 0) {
                                        final LatLng currentLatLng =
                                        LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
                                        _controller?.animateCamera(CameraUpdate.newLatLng(currentLatLng));
                                        updateMap(_currentPosition!);
                                      }
                                    }
                                  });
                                });
                                addMarker(LatLng(_currentPosition!.latitude, _currentPosition!.longitude));
                                _timerUtil.startTimer((seconds) {
                                  // 여기서 타이머 갱신된 값을 처리할 수 있습니다.
                                  // 예를 들어, 타이머 갱신된 값을 UI에 표시하거나 다른 작업을 수행할 수 있습니다.
                                });
                              } else {
                                addMarker(LatLng(_currentPosition!.latitude, _currentPosition!.longitude));
                                final locationUpdateTimer = _locationUpdateTimer;
                                if (locationUpdateTimer != null) {
                                  locationUpdateTimer.cancel(); // 타이머 취소
                                }
                                _timerUtil.stopTimer();
                                showExitConfirmationDialog(context);
                              }
                            });
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                              Size(MediaQuery.of(context).size.width * 0.8, 50),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                              if (isRecording) {
                                // isRecording이 true일 때 버튼의 배경색을 옅은 빨강색으로 설정
                                return Colors.red;
                              } else {
                                return Palette.logoColor; // 그 외에는 흰색으로 설정
                              }
                            }),
                          ),
                          child: Text(isRecording ? '산책종료' : '산책시작'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}