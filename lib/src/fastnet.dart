library fastnet;

import 'dart:async';

import 'package:fastnet/src/model/result.dart';
import 'package:puppeteer/puppeteer.dart';

/// A .
class FastNet {
  //Duration in milliseconds
  static void _delay(duration) {
    Future.delayed(Duration(milliseconds: duration));
  }

  static Future<void> init({
    required Page page,
    required Browser browser,
    required StreamController streamController,
  }) async {
    while (true) {
      var content = await page.evaluate('''x=>{
    const downloadSpeedValue= document.querySelector("#speed-value").textContent;
    const downloadSpeedUnit =document.querySelector("#speed-units").textContent;
    const uploadSpeedValue = document.querySelector("#upload-value").textContent;
    const uploadSpeedUnit = document.querySelector("#upload-units").textContent;
    const isDone= Boolean(
					document.querySelector('#speed-value.succeeded') && document.querySelector('#upload-value.succeeded')
				);
    return{downloadSpeedValue, downloadSpeedUnit, uploadSpeedValue, uploadSpeedUnit, isDone};
  }''', args: []);
      final result = Result.fromJson(content);

      if (result.downloadSpeedValue > 0 && !result.isDone) {
        streamController.sink.add(result);
      }

      if (result.isDone) {
        await browser.close();
        streamController.sink.add(result);
        await streamController.close();
        return;
      }
    }
  }

  FutureOr<Stream<Result>> getSpeed() async {
    final _streamController = StreamController<Result>();
    final browser = await puppeteer.launch(timeout: Duration(minutes: 10));
    final page = await browser.newPage();
    await page.goto('https://fast.com/#');
    init(
      page: page,
      browser: browser,
      streamController: _streamController,
    );

    return _streamController.stream;
  }
}
