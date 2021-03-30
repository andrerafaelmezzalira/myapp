import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:myapp/AddStudent.dart';
import 'package:myapp/Students.dart';
import 'package:myapp/SynchronizedStudents.dart';
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
          if (connected) {
            SynchronizedStudents.isOfflineData().then((isOffline) => {
                  if (isOffline)
                    {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Synchronized"),
                          content: Text("Push data to server."),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Send'),
                              onPressed: () {
                                SynchronizedStudents.synchronized();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      )
                    }
                });
          }
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
                  onPressed: () async {
                    if (myController.text.isNotEmpty) {
                      AddStudent.add(myController.text, connected);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                    }
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
