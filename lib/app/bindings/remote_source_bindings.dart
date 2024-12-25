import 'package:flutter_getx_template/app/data/remote/api_data_source.dart';
import 'package:flutter_getx_template/app/data/remote/api_data_source_impl.dart';
import 'package:get/get.dart';

class RemoteSourceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiDataSource>(
      () => ApiDataSourceImpl(),
      tag: (ApiDataSource).toString(),
    );
  }
}
