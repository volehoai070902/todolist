import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/state/user_info/model/user_infor.dart';

class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier() : super(UserModel(email: '', password: ''));

  void setEmailAndPassword(String email, String password){
    state = UserModel(email: email, password: password);
  }
}