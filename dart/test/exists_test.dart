import 'harness.dart';

import '../lib/BluefinShieldconexSDK.dart';

void tests() {
  describe('exists', () {
    test('test-mode', (t) async {
      final testsdk = BluefinShieldconexSDK.test();
      equal(true, null != testsdk);
    });
  });
}
