import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('tapsell_plus');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {

  });

  test('Passing test', () {
    print("Passing test started");
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
