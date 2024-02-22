import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final loadDateProvider = Provider<String>((ref){
  DateTime date = DateTime.now();
  return DateFormat('EEEE, d MMM, yyyy').format(date);
} );