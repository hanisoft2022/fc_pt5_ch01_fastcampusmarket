import 'package:fastcampusmarket/features/count/presentation/w_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:velocity_x/velocity_x.dart';

class MyHomePage extends HookWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);

    void incrementCounter() {
      counter.value++;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            'You have pushed the button this many times:'.text.make(),
            '${counter.value}'.text.headlineLarge(context).make(),
          ],
        ),
      ),
      floatingActionButton: FAB(incrementCounter),
    );
  }
}
