import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/state/auth/provider/auth_state_provider.dart';

final isLoadingProvider = Provider((ref){
  final authState = ref.watch(authStateProvider);
  return authState.isLoading;
});