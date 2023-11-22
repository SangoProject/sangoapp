import 'package:flutter/material.dart';
import '../../config/palette.dart';
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
        color: Palette.green3,
        width: bannerwidth,
        height: bannerheight / 16,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '오늘의 안전정보 알리미',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.notification_important_outlined,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}