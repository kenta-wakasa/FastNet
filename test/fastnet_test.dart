import 'package:fastnet/fastnet.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test network speed', () async {
    final fastnet = FastNet();
    final response = await fastnet.getSpeed();

    response.listen((Result result) {
      print(
          "Download: ${result.downloadSpeedValue} ${result.downloadSpeedUnit}\n Upload:  ${result.uploadSpeedValue} ${result.uploadSpeedUnit}");
    });
  });
}
