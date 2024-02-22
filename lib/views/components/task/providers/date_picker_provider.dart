import 'package:hooks_riverpod/hooks_riverpod.dart';

final datePickerProvider = StateProvider<DateTime?>((ref) => DateTime.now());