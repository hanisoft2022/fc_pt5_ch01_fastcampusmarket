import 'package:flutter/material.dart';

class FAB extends StatelessWidget {

final VoidCallback incrementCounter;

const FAB( this.incrementCounter, {super.key});


  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
    onPressed: incrementCounter,
    tooltip: 'Increment',
  child: const Icon(Icons.add),
  );
  }
}
