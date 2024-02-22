import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/state/auth/provider/auth_state_provider.dart';
import 'package:todo_list/state/auth/provider/is_logged_in_provider.dart';
import 'package:todo_list/state/user_info/model/user_infor.dart';
import 'package:todo_list/state/user_info/providers/user_infor_password_provider.dart';
import 'package:todo_list/views/main/main_view.dart';

final visionProvider = StateProvider<bool>((ref) => true);
final buttonStateProvider = StateProvider((ref) => true);

class LoginWithEmailView extends ConsumerWidget{
  UserModel userModel = UserModel(email: '', password: '');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text("Add your email and password."),
              const SizedBox(
                height: 20,
              ),
              Consumer(
                builder: (context, ref, child) {
                  return Container(
                    child: TextField(
                      onChanged: (value) {
                        userModel.useremail = value;
                        ref
                            .read(userNotifierProvider.notifier)
                            .setEmailAndPassword(
                                userModel.email, userModel.password);
                      },
                      decoration: InputDecoration(
                        labelText: "Your Email",
                        border: OutlineInputBorder(),
                        hintText: "Your email",
                      ),
                    ),
                  );
                },
              ),
              Consumer(
                builder: (context, ref, child) {
                  final isVisiable = ref.watch(visionProvider);
                  return Container(
                    padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
                    child: TextField(
                      onChanged: (value) {
                        userModel.userpassword = value;
                        ref
                            .read(userNotifierProvider.notifier)
                            .setEmailAndPassword(
                                userModel.email, userModel.password);
                      },
                      obscureText: isVisiable,
                      decoration: InputDecoration(
                          labelText: "Your Password",
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              ref.read(visionProvider.notifier).state =
                                  !isVisiable;
                            },
                            icon: Icon(isVisiable
                                ? Icons.visibility_off
                                : Icons.visibility),
                          )),
                    ),
                  );
                },
              ),
              Consumer(
                builder: (context, ref, child) {
                  bool isEnable;
                  final user = ref.watch(userNotifierProvider);

                  if (user.email == '' || user.password == '') {
                    isEnable = false;
                  } else {
                    isEnable = true;
                  }
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)
                      ),
                      onPressed: isEnable ? ()async {
                        await ref.read(authStateProvider.notifier).loginWithPassword(email: user.email, password: user.password);
                        final isLoggedIn = ref.watch(isLoggedInProvider);
                        if (isLoggedIn) {
                          Navigator.of(context).pop();
                        }
                      } : null,
                      child: Text("Log in"));
                },
              )
            ],
          ),
        ));
  }

}