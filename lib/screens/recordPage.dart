import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
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
  // late LocationData _locationData;
  Position? _currentPosition;
  bool startRecording = false; // 기록중인 상태 여부
  final TimerUtil _timerUtil = TimerUtil();
  final StreamController<int> _timerStreamController = StreamController<int>();
  late Timer _locationUpdateTimer; // 위치 업데이트용 타이머

  @override
  void dispose() {
    _timerStreamController.close();
    _locationUpdateTimer?.cancel(); // 타이머 종료
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
            15.0, // 줌 값 변경
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   getLocation();
  //
  //   // 1초마다 위치 업데이트하는 타이머 시작
  //   _locationUpdateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     getLocation();
  //   });
  // }

  final List<Marker> markers = [];

  addMarker(cordinate) {
    int id = Random().nextInt(100);

    setState(() {
      markers.add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
    });
  }

  Stream<int> getTimerStream() {
    if (startRecording) {
      _timerStreamController.sink.add(0); // 0으로 초기화
      return _timerUtil.timerStream; // startRecording이 true일 때 타이머 스트림을 반환
    } else {
      return Stream<int>.empty(); // startRecording이 false일 때 빈 스트림을 반환
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Position>(
        future: _getLocation(),
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
          child: Stack(
            children: <Widget>[
              GoogleMap(
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
                ),
                compassEnabled: true,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
            ],
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
                      Text('0.0km',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      TextButton(
                        onPressed: () {
                          // getLocation();
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
                              if (!startRecording) {
                                _timerUtil.resetTimer(); // 타이머 초기화
                              }
                              startRecording = !startRecording;
                              if (startRecording) {
                                // 위치 가져오고 마커 추가
                                getLocation().then((position) {
                                  if (_currentPosition != null) {
                                    final LatLng currentLatLng =
                                    LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
                                    _controller?.animateCamera(CameraUpdate.newLatLng(currentLatLng));
                                    // _controller?.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng, 15));
                                    addMarker(currentLatLng);
                                  }
                                });
                                _timerUtil.startTimer((seconds) {
                                  // 여기서 타이머 갱신된 값을 처리할 수 있습니다.
                                  // 예를 들어, 타이머 갱신된 값을 UI에 표시하거나 다른 작업을 수행할 수 있습니다.
                                });
                              } else {
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
                              if (startRecording) {
                                // startRecording이 true일 때 버튼의 배경색을 옅은 빨강색으로 설정
                                return Colors.red;
                              } else {
                                return Palette.logoColor; // 그 외에는 흰색으로 설정
                              }
                            }),
                          ),
                          child: Text(startRecording ? '산책종료' : '산책시작'),
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

  Future<Position> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
  // void _onMyLocationClick() {
  //   Fluttertoast.showToast(
  //     msg: 'Current location:\nLat: ${_controller?.cameraPosition.target.latitude}, Lng: ${_controller?.cameraPosition.target.longitude}',
  //     toastLength: Toast.LENGTH_LONG,
  //   );
  // }
  //
  // bool _onMyLocationButtonPress() {
  //   Fluttertoast.showToast(msg: 'MyLocation button clicked', toastLength: Toast.LENGTH_SHORT);
  //   return false; // Return false to allow the default behavior to occur.
  // }
}
// }
      // WillPopScope(
      // onWillPop: () async {
      //   return false;
      // },
      // child: MaterialApp(
      //   debugShowCheckedModeBanner: false,
      //   home: Scaffold(
      //     body:
          // Column(
          //   children: [
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.7,
                // child: Stack(
                  // children: <Widget>[
                    // GoogleMap(
                    //   onMapCreated: (controller) {
                    //     setState(() {
                    //       _controller = controller;
                    //     });
                    //   },
                    //   // markers: markers.toSet(),
                    //   onTap: (cordinate) {
                    //     _controller?.animateCamera(CameraUpdate.newLatLng(cordinate));
                    //   },
                    //   onCameraMove: (position) {
                    //     setState(() {
                    //       _currentPosition = position.target as Position?; // 카메라 위치 변경 정보를 저장
                    //     });
                    //   },
                    //   initialCameraPosition: _currentPosition != null
                    //       ? CameraPosition(
                    //     target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                    //     zoom: 18.0,
                    //   )
                    //       : CameraPosition(
                    //     target: LatLng(37.541, 126.986),
                    //     zoom: 11.0,
                    //   ),
                    //   compassEnabled: true,
                    // ),
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: Icon(
                    //     Icons.navigation,
                    //     color: Colors.blue,
                    //     size: 48,
                    //   ),
                    // ),
                  // ],
                // ),
              // ),
              // Expanded(
              //   child: Container(
              //     padding: EdgeInsets.all(24.0),
              //     height: MediaQuery.of(context).size.height * 0.2,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(40.0), // 둥근 모서리 설정
              //       border: Border.all(width: 1.0, color: Palette.logoColor),
              //     ),
              //     child: Column(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //             children: [
              //               StreamBuilder<int>(
              //                 stream: getTimerStream(), // 조건에 따라 다른 스트림 반환
              //                 builder: (context, snapshot) {
              //                   final int seconds = snapshot.data ?? 0;
              //                   final String formattedTime = TimerUtil.getFormattedTime(seconds);
              //                   return Text(
              //                     formattedTime,
              //                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //                   );
              //                 },
              //               ),
              //               Text('0.0km',
              //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              //               TextButton(
              //                 onPressed: () {
              //                   // getLocation();
              //                 },
              //                 child: Text('현위치', style: TextStyle(fontSize: 16),),
              //               )
              //             ],
              //           ),
              //         ),
              //         Expanded(
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.all(4.0),
              //                 child: ElevatedButton(
              //                   onPressed: () {
              //                     setState(() {
              //                       // if (!startRecording) {
              //                       //   _timerUtil.resetTimer(); // 타이머 초기화
              //                       // }
              //                       // startRecording = !startRecording;
              //                       // if (startRecording) {
              //                       //   // 위치 가져오고 마커 추가
              //                       //   getLocation().then((position) {
              //                       //     if (_currentPosition != null) {
              //                       //       final LatLng currentLatLng =
              //                       //       LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
              //                       //       _controller?.animateCamera(CameraUpdate.newLatLng(currentLatLng));
              //                       //       _controller?.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng, 15));
              //                       //       addMarker(currentLatLng);
              //                       //     }
              //                       //   });
              //                       //   _timerUtil.startTimer((seconds) {
              //                       //     // 여기서 타이머 갱신된 값을 처리할 수 있습니다.
              //                       //     // 예를 들어, 타이머 갱신된 값을 UI에 표시하거나 다른 작업을 수행할 수 있습니다.
              //                       //   });
              //                       // } else {
              //                       //   _timerUtil.stopTimer();
              //                       //   showExitConfirmationDialog(context);
              //                       // }
              //                     });
              //                   },
              //                   style: ButtonStyle(
              //                     minimumSize: MaterialStateProperty.all<Size>(
              //                       Size(MediaQuery.of(context).size.width * 0.8, 50),
              //                     ),
              //                     foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              //                     backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              //                       if (startRecording) {
              //                         // startRecording이 true일 때 버튼의 배경색을 옅은 빨강색으로 설정
              //                         return Colors.red;
              //                       } else {
              //                         return Palette.logoColor; // 그 외에는 흰색으로 설정
              //                       }
              //                     }),
              //                   ),
              //                   child: Text(startRecording ? '산책종료' : '산책시작'),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
        //     // ],
        //   ),
        // ),
//       ),
//     );
//   }
// }
