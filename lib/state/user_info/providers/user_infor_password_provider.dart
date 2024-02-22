import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/state/user_info/model/user_infor.dart';
import 'package:todo_list/state/user_info/notifiers/user_infor_password_notifier.dart';


final userNotifierProvider =StateNotifierProvider<UserNotifier, UserModel>((ref) => UserNotifier());