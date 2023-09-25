// import 'dart:math';

import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proj4dart/proj4dart.dart';
// import 'map_data/mapLatLng.dart';
// import 'package:sangoproject/screens/course_data/courseInfo.dart';

class SearchDetailPage extends StatefulWidget{
  dynamic data; // 코스명, 시간, 거리, 난이도
  dynamic detail; // 포인트번호, 포인트명칭, x좌표, y좌표 (courseInfo.dart 참고)
  SearchDetailPage(this.data, this.detail);

  @override
  State<StatefulWidget> createState(){
    return _SearchDetailPage(data, detail);
  }
}

class _SearchDetailPage extends State<SearchDetailPage>{
  dynamic data;
  dynamic detail;
  _SearchDetailPage(this.data, this.detail);

  // GoogleMapController? _controller;
  // Position? _currentPosition;

  final Completer<GoogleMapController> _controller = Completer();
  final _markers = <Marker>{};
  // final List<Marker> _markers = [];
  final List<LatLng> _points = [];
  final Set<Polyline> _polylines = Set<Polyline>();

  // final List<Map<String, dynamic>> _points = [];

  // Future<void> processdetail() async {
  //   for (int index = 0; index < detail.length; index++) {
  //     LatLng googlePoint = await utmkToGoogle(detail[index].x, detail[index].y);
  //     _points.add({
  //       "name": "${detail[index].cpi_name}",
  //       "latitude": googlePoint.latitude,
  //       "longitude": googlePoint.longitude,
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _setupMarkersAndPolylines();
  }

  // Future<void> _initializeMarkers() async {
  //   await processdetail(); // processdetail 함수가 완료될 때까지 기다림
  //
  //   _markers.addAll(
  //     _points.map(
  //           (e) => Marker(
  //         markerId: MarkerId(e['name'] as String),
  //         infoWindow: InfoWindow(title: e['name'] as String),
  //         position: LatLng(
  //           e['latitude'] as double,
  //           e['longitude'] as double,
  //         ),
  //       ),
  //     ),
  //   );
  // }


  Future<void> _setupMarkersAndPolylines() async {
    for (int index = 0; index < detail.length; index++) {
      final x = double.parse(detail[index].x);
      final y = double.parse(detail[index].y);

      final point = LatLng(x, y);
      _points.add(point);

      final marker = Marker(
        markerId: MarkerId(index.toString()),
        position: point,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: '${detail[index].cpi_name}'), // 마커에 정보 표시
      );
      _markers.add(marker);
    }
    _polylines.add(Polyline(
      polylineId: PolylineId('path'),
      points: _points,
      color: Colors.blue, // 선 색상
      width: 10, // 선 두께
    ));

    setState(() {});
  }


  // void _addMarkersOnMap() {
  //   for (int index = 0; index < detail.length; index++) {
  //     // UTMK 좌표를 Google 좌표로 변환
  //     LatLng googlePoint = utmkToGoogle(detail[index].x, detail[index].y);
  //
  //     // 새로운 마커 생성
  //     Marker marker = Marker(
  //       markerId: MarkerId(index.toString()),
  //       position: googlePoint,
  //       icon: BitmapDescriptor.defaultMarker,
  //       infoWindow: InfoWindow(title: 'Point $index'),
  //     );
  //     _markers.add(marker);
  //   }
  // }

  final _tuple_utmk_google = ProjectionTuple(
    fromProj: Projection.parse( // from 중부원점(GRS80)-falseY:60000 to WGS84
        '+proj=tmerc +lat_0=37.509290 +lon_0=127.062459 +k=1 +x_0=205525.1279 +y_0=445538.6724 +ellps=GRS80 +units=m +no_defs'),
    toProj: Projection.parse('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'),
  );

  LatLng utmkToGoogle(String x, String y) {
    var utmkPoint = Point(x: double.parse(x), y: double.parse(y));
    var googlePoint = _tuple_utmk_google.forward(utmkPoint);

    return LatLng(googlePoint.y, googlePoint.x);
  }

  LatLng _calculateCenterPoint(List<dynamic> detail) {
    if (detail.isEmpty) {
      return LatLng(37.541, 126.986); // 기본값 설정
    }

    double centerX = 0.0;
    double centerY = 0.0;

    for (int index = 0; index < (detail.length)/2; index++) {
      centerX = double.parse(detail[index].x);
      centerY = double.parse(detail[index].y);
    }

    double center = ((detail.length)/2);

    print('center $center');
    print('Point $centerX, $centerY');

    return utmkToGoogle(centerX.toString(), centerY.toString());
  }

  @override
  Widget build(BuildContext context) {
    // LatLng? location = LatLng(37.541, 126.986);
    double? zoomLevel = 14;

    return Scaffold(
      appBar: AppBar(
        title: Text('산책로 세부 정보'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                initialCameraPosition: CameraPosition(
                  target: _calculateCenterPoint(detail),
                  zoom: zoomLevel,
                ),
                markers: Set<Marker>.of(_markers),
                // polylines: _polylines,
              ),
            ),
            Row(
              children: [
                Text(data["course_name"]),
                ElevatedButton(
                    onPressed: (){
                      for (int index = 0; index < detail.length; index++) {
                        // UTMK 좌표를 Google 좌표로 변환하고 콘솔에 출력
                        LatLng googlePoint = utmkToGoogle(detail[index].x, detail[index].y);
                        print('Point $index - Google X: ${googlePoint.latitude.toString()},'
                            ' Y: ${googlePoint.longitude.toString()}');
                      }
                    },
                    child: Text('data'))
              ],
            ),
            Text("산책시간: " + data["lead_time"].toString() + "분"),
            Text("산책거리: " + data["distance"].toString() + "km"),
            Text("난이도: " + data["course_level"].toString()),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index){
                  return Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.swipe_down_alt),
                        Text(detail[index].cpi_idx.toString() + " " + detail[index].cpi_name),
                      ],
                    ),
                  );
                },
                itemCount: detail.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
