import 'package:myapp/Student.dart';
import 'package:myapp/Storage.dart';

class StudentStorage {
  static void add(final String name) async {
    final List<Student> students = await loadStudents();
    students.add(new Student(name, 0));
    addAll(students);
  }

  static void addAll(final List<Student> students) async {
    if (students.isNotEmpty) {
      await Storage.write("students", students);
    }
  }

  static Future<List<Student>> loadStudents() async {
    final List<Student> students = <Student>[];
    List<dynamic> studentsOffline = await Storage.read("students");
    if (studentsOffline.isEmpty) {
      return students;
    }
    for (int i = 0; i < studentsOffline.length; i++) {
      students.add(
          new Student(studentsOffline[i]['name'], studentsOffline[i]['id']));
    }
    return students;
  }
}
