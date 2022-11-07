import 'package:flutter_test/flutter_test.dart';
import 'package:provider101/samples/znews/data/local/database_helper/base_hive.dart';

void main() {
  late LocalDataBaseHelper sut;

  setUp(() {
    sut = LocalDataBaseHelperHiveImpl();
  });
}
