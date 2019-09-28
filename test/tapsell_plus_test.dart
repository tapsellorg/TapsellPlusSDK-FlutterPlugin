import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tapsell_plus/tapsell_plus.dart';

void main() {
  const MethodChannel channel = MethodChannel('tapsell_plus');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await TapsellPlus.platformVersion, '42');
  });
}
