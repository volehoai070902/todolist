
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/state/auth/backend/authenticator.dart';
import 'package:todo_list/state/auth/model/auth_result.dart';
import 'package:todo_list/state/auth/model/auth_state.dart';
import 'package:todo_list/state/posts/typedefs/user_id.dart';
import 'package:todo_list/state/user_info/backend/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState>{
  final _authenticator = Authenticator();
  final _userInfoStorage = UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unknown()){
    if(_authenticator.isAlreadyLoggedIn){    
      state = AuthState(result: AuthResult.success, isLoading: false, userId: _authenticator.userId);
    }
  }

  Future<void> logOut() async{
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = AuthState.unknown();
  }

  Future<void> loginWithGoogle() async{
    state = state.copiedWithIsLoading(true);
    final result =await _authenticator.loginWithGoogle();
    final userId =_authenticator.userId;
    if (result == AuthResult.success && userId != null){
      await saveUserInfo(userId: userId);
    }
    state = AuthState(result: result, isLoading: false, userId: _authenticator.userId);
  }

  Future<void> loginWithFacebook()async{
    state = state.copiedWithIsLoading(true);
    final result =await _authenticator.loginWithFacebook();
    final userId =_authenticator.userId;
    if (result == AuthResult.success && userId != null){
      
      await saveUserInfo(userId: userId);
    }
    state = AuthState(result: result, isLoading: false, userId: _authenticator.userId);
  }

  Future<void> loginWithPassword({required String email, required String password})async{
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.signinWithPassword(email:email , password: password);
    final userId =_authenticator.userId;

    if (result == AuthResult.success && userId != null){
      await saveUserInfo(userId: userId);
    }
    
    state = AuthState(result: result, isLoading: false, userId: _authenticator.userId);
  }
  
  Future<void> saveUserInfo({required UserId userId}){

    return _userInfoStorage.saveUserInfo(userId: userId, displayName: _authenticator.displayName, email: _authenticator.email);
  }
}