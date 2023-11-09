import 'package:flutter/material.dart';
import 'disasterList.dart';

class Disaster extends StatelessWidget {
  const Disaster({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerheight = MediaQuery.of(context).size.height;
    final bannerwidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DisasterListPage()),
        );
      },
      child: Container(
        width: bannerwidth,
        height: bannerheight / 16,
        alignment: Alignment.center,
        color: Colors.grey,
        child: Text(
          '- - - > 재난정보를 확인하세요 < - - -',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}