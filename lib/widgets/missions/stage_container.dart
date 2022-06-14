import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StageContainer extends StatelessWidget {
  const StageContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.amber[600],
      child: const Center(child: Text('Entry A')),
    );
  }
}
