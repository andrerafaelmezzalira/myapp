import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/Http.dart';
import 'package:myapp/Student.dart';
import 'package:myapp/StudentStorage.dart';

class Students extends StatelessWidget {
  final bool connected;

  Students(this.connected);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: students(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return listView(snapshot.data);
          } else if (snapshot.hasError) {
            return Text("");
          }
          return CircularProgressIndicator();
        });
  }

  Future<List<Student>> students() async {
    if (this.connected) {
      try {
        final response = await Http.get();
        if (response.statusCode == 200 && response.body != '[]') {
          final List<Student> students = load(response);
          StudentStorage.addAll(students);
          return students;
        }
      } catch (e) {
        print('ocorreu um erro de get');
        print(e);
      }
    }
    return await StudentStorage.loadStudents();
  }

  List<Student> load(final response) {
    return json
        .decode(response.body)
        .map<Student>((job) => new Student.fromJson(job))
        .toList();
  }

  ListView listView(final students) {
    return ListView.builder(
        padding: EdgeInsetsDirectional.fromSTEB(10, 150, 0, 0),
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              '${students[index].name}',
              style: (students[index].id == 0
                  ? TextStyle(color: Colors.red, fontWeight: FontWeight.bold)
                  : TextStyle(fontWeight: FontWeight.bold)),
            ),
          );
        });
  }
}
