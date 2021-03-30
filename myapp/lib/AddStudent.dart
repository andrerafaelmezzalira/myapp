import 'package:myapp/Http.dart';
import 'package:myapp/StudentStorage.dart';

class AddStudent {
  static void add(final String name, final bool connected) {
    if (connected) {
      try {
        Http.post(name);
      } catch (e) {
        print('ocorreu um erro no post');
        print(e);
        StudentStorage.add(name);
      }
    } else {
      StudentStorage.add(name);
    }
  }
}
