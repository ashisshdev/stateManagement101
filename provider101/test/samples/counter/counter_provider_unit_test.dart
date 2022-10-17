import 'package:flutter_test/flutter_test.dart';
import 'package:provider101/samples/counter/counter_provider.dart';

void main() {
  late CounterProvider sut;

  /// sut == Subject under test

  setUp(() {
    sut = CounterProvider();
  });

  group('initial values', () {
    test("Initial value of count variable", () async {
      expect(sut.count, 0);
    });
  });

  group('counter provider methods', () {
    test("increment", () async {
      int valueBefore = sut.count;
      sut.increment();
      expect(sut.count, valueBefore + 1);
    });

    test("decrement", () async {
      int valueBefore = sut.count;
      sut.decrement();
      expect(sut.count, valueBefore - 1);
    });

    test("reset", () async {
      sut.reset();
      expect(sut.count, 0);
    });
  });
}
