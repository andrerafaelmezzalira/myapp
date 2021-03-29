import 'package:myapp/Http.dart';
import 'package:myapp/Student.dart';
import 'package:myapp/StudentStorage.dart';

class SynchronizedStudents {
  static void synchronized() async {
    final List<Student> studentsOffline = await StudentStorage.loadStudents();
    studentsOffline.forEach((student) async {
      if (student.id == 0) {
        await Http.post(student.name);
      }
    });
  }
}
