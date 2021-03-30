import 'package:myapp/Http.dart';
import 'package:myapp/Student.dart';
import 'package:myapp/StudentStorage.dart';

class SynchronizedStudents {
  static void synchronized(List<Student> students) {
    students.forEach((student) {
      try {
        Http.post(student.name);
      } catch (e) {
        print('ocorreu um erro no post syncronized');
        print(e);
      }
    });
  }

  static Future<List<Student>> studentsOffline() async {
    final List<Student> studentsOffline = await StudentStorage.loadStudents();
    return studentsOffline.where((i) => i.id == 0).toList();
  }
}
