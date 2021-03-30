import 'package:myapp/Http.dart';
import 'package:myapp/Student.dart';
import 'package:myapp/StudentStorage.dart';

class SynchronizedStudents {
  static void synchronized() async {
    final List<Student> studentsOffline = await StudentStorage.loadStudents();
    studentsOffline.forEach((student) {
      if (student.id == 0) {
        try {
          Http.post(student.name);
        } catch (e) {
          print('ocorreu um erro no post syncronized');
          print(e);
        }
      }
    });
  }

  static Future<bool> isOfflineData() async {
    final List<Student> studentsOffline = await StudentStorage.loadStudents();
    return studentsOffline.where((i) => i.id == 0).isNotEmpty;
  }
}
