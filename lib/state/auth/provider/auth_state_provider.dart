import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/state/auth/model/auth_state.dart';
import 'package:todo_list/state/auth/notifiers/auth_state_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) => AuthStateNotifier());