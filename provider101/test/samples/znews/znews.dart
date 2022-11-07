import 'package:intl/intl.dart';

void main() {
  print(DateTime.now());

  DateTime now = DateTime.now();

  DateTime twoHourBefore = DateTime.now().subtract(const Duration(hours: 1, minutes: 50));

  final formatter = DateFormat('yyyy mm dd kk:mm:00');

//  final formatter2 = DateFormat('yyyy mm dd kk:mm:00');

  String formatted1 = formatter.format(now);

  String formatted2 = formatter.format(twoHourBefore);

  print(formatted1);
  print(formatted2);

  DateTime formatted3 = DateTime.parse(formatted1);
  DateTime formatted4 = DateTime.parse(formatted2);

  print(formatted3);
  print(formatted4);

  print(DateTime.now().isBefore(formatted3));
  print(DateTime.now().isBefore(formatted4));
}
