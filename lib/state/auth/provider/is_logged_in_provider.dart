
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/state/auth/model/auth_result.dart';
import 'package:todo_list/state/auth/provider/auth_state_provider.dart';

final isLoggedInProvider = Provider<bool>((ref)
{
  final authProvider = ref.watch(authStateProvider);
  
  return authProvider.result == AuthResult.success;
});