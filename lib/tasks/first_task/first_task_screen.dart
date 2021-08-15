import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
 First Task : app consists of FAB and container
 when i pressed on FAB it changes container Color
 but when i pressed on FAB it Rebuild Background widget
 which it doesn't no need to rebuild
 you need to optimize build function as
 when i pressed on Button don't rebuild Background widget
 */
class BackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Building BackgroundWidget");

    return Container(color: Colors.amber);
  }
}

class FirstTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Building FirstTaskScreen");
    return Scaffold(
      appBar: AppBar(
        title: Text("First task"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ChangeColor>().changeColor();
        },
        child: Icon(Icons.colorize),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: BackgroundWidget()),
          Consumer<ChangeColor>(
            builder: (context, data, child) => Center(
              child: Container(
                width: 100,
                height: 100,
                color: data._randomColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChangeColor extends ChangeNotifier {
  Color _randomColor = Colors.black;
  final _random = Random();

  void changeColor() {
    _randomColor = Colors.primaries[_random.nextInt(Colors.primaries.length)];
    notifyListeners();
  }
}
