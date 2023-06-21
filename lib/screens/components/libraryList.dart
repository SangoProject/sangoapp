import 'package:flutter/material.dart';

class LibraryList extends StatelessWidget {
  //임의의 데이터
  final List sample = ["상수동 산책길", "20내외 산책길", "기타"];

  @override
  Widget build(BuildContext context) {
    // return Container(
    return Container(
      height: 180,
      child: ListView.separated(
        itemBuilder: (context, index) => Container(
          child: SizedBox(
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      sample[index],
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )
                ),
              ],
            ),
          ),
        ),
        separatorBuilder: (context, index) => Divider(
          thickness: 0.5,
          height: 0,
        ),
        itemCount: sample.length,
      ),
    );
  }
}