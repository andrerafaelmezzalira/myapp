import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:myapp/Students.dart';
import 'package:myapp/Http.dart';
import 'package:myapp/StudentStorage.dart';
import 'package:myapp/main.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final myController = TextEditingController();
          final connected = connectivity != ConnectivityResult.none;
          return Stack(
            fit: StackFit.expand,
            children: [
              child,
              Positioned(
                height: 34.0,
                left: 0.0,
                right: 0.0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: Text(connected ? 'ONLINE' : 'OFFLINE'),
                  ),
                ),
              ),
              Center(child: Students(connected)),
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 40.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: myController,
                  ),
                ),
              ),
              Positioned(
                width: 50.0,
                left: 10.0,
                top: 110.0,
                child: ElevatedButton(
                  onPressed: () {
                    if (!connected) {
                      StudentStorage.add(myController.text);
                    } else {
                      Http.post(myController.text);
                    }
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          );
        },
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
