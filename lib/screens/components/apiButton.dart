import 'package:flutter/material.dart';
import '../detailPage.dart';

class MyButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final apiExample = ApiExample();
        apiExample.fetchData();
      },
      child: Text('Fetch Data'),
    );
  }
}