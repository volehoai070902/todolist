import 'package:logger/logger.dart';

class LoggerCustom extends Logger{
  LoggerCustom._();
  static final LoggerCustom _share = LoggerCustom._(
  );
  factory LoggerCustom.instance() => _share;
}