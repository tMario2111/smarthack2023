import 'package:pocketbase/pocketbase.dart';

class PbInstance {
  static late PocketBase _pb;

  static void init() async {
    _pb = PocketBase('http://127.0.0.1:8090');
    await _pb
        .collection('students')
        .authWithPassword('ungureanuv@cnmk.com', '12345678');
  }

  static PocketBase getPb() {
    return _pb;
  }
}
