import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final timePickerProvider = StateProvider<TimeOfDay>((ref) => TimeOfDay.now());