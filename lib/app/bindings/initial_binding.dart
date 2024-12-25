import 'package:get/get.dart';

import 'local_source_bindings.dart';
import 'remote_source_bindings.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    RemoteSourceBindings().dependencies();
    LocalSourceBindings().dependencies();
  }
}
