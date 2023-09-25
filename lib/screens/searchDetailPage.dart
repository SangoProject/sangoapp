// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map_data/mapLatLng.dart';
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

  GoogleMapController? _controller;
  // Position? _currentPosition;

  @override
  Widget build(BuildContext context) {
    // LatLng? location = areaGuLocations[data.area_gu];
    // double? zoomLevel = areaGuZoomLevels[data.area_gu];

    LatLng? location = LatLng(37.541, 126.986);
    double? zoomLevel = 11;

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
                onMapCreated: (controller) {
                  setState(() {
                    _controller = controller;
                    if (location != null && zoomLevel != null) {
                      _controller!.animateCamera(
                          CameraUpdate.newLatLngZoom(location, zoomLevel));
                    }
                  });
                },
                initialCameraPosition: CameraPosition(
                    target: location, zoom: zoomLevel),
              ),
            ),
            Text(data["course_name"]),
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
