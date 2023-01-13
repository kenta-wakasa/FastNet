import 'package:equatable/equatable.dart';

class Result extends Equatable {
  final double downloadSpeedValue;
  final String downloadSpeedUnit;
  final double uploadSpeedValue;
  final String uploadSpeedUnit;
  final bool isDone;

  Result({
    required this.downloadSpeedUnit,
    required this.downloadSpeedValue,
    required this.isDone,
    required this.uploadSpeedUnit,
    required this.uploadSpeedValue,
  });

  factory Result.fromJson(Map<dynamic, dynamic> json) {
    return Result(
      downloadSpeedUnit: json["downloadSpeedUnit"] ?? "",
      downloadSpeedValue: double.tryParse(json["downloadSpeedValue"]) ?? 0.0,
      isDone: json["isDone"] ?? false,
      uploadSpeedUnit: json["uploadSpeedUnit"] ?? "",
      uploadSpeedValue: double.tryParse(json["uploadSpeedValue"]) ?? 0.0,
    );
  }

  @override
  List<Object> get props => [
        downloadSpeedUnit,
        downloadSpeedValue,
        isDone,
        uploadSpeedUnit,
        uploadSpeedValue,
      ];
}
