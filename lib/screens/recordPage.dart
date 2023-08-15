import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sangoproject/config/palette.dart';

class RecordPage extends StatefulWidget{
  const RecordPage({Key? key}) : super(key: key);

  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage>{
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.541, 126.986);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

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
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 200,
                color: Palette.activeColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}