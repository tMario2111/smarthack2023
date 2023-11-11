import 'package:pocketbase/pocketbase.dart';

class PbInstance {
  static late PocketBase _pb;
  static late final String id;
  static String? first_name;

  static Future<void> init() async {
    _pb = PocketBase('http://127.0.0.1:8090');
    await _pb
        .collection('students')
        .authWithPassword('ungureanuv@cnmk.com', '12345678');
    id = _pb.authStore.model.id;
    first_name =
        (await _pb.collection('students').getList(filter: 'id = "$id"'))
            .items[0]
            .getStringValue('first_name');
  }

  static PocketBase getPb() {
    return _pb;
  }
}
