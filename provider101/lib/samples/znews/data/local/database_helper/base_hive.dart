import 'package:hive_flutter/hive_flutter.dart';

abstract class LocalDataBaseHelper {
  Future<void> init();

  dynamic get(String key);

  /// for both insert and update
  Future<void> set(String key, dynamic data);

  bool has(String key);

  Future<void> remove(String key);

  Future<void> close();

  /// clear cache
  Future<void> clear();
}

class LocalDataBaseHelperHiveImpl implements LocalDataBaseHelper {
  // initializing the HiveBoxObject inside the constructor is also a great way
  // as soon as the class is registered by the dependencyInjector, the function inside the constructor will trigger
  // LocalDataBaseHelperHiveImpl() {
  //   init();
  // }

  late Box hiveBox;

  Future<void> openBox([String boxName = 'Articles']) async {
    hiveBox = await Hive.openBox(boxName);
  }

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    await openBox();
  }

  @override
  Future<void> remove(String key) async {
    hiveBox.delete(key);
  }

  @override
  dynamic get(String key) {
    return hiveBox.get(key);
  }

  @override
  bool has(String key) {
    return hiveBox.containsKey(key);
  }

  @override
  Future<void> set(String key, dynamic data) async {
    try {
      return await hiveBox.put(key, data);
    } catch (e) {
      throw HiveError("Hive Error");
    }
  }

  @override
  Future<void> clear() async {
    await hiveBox.clear();
  }

  @override
  Future<void> close() async {
    await hiveBox.close();
  }
}
