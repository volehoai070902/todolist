import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/state/auth/provider/auth_state_provider.dart';

class LoginView extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: ()async{
              await ref.read(authStateProvider.notifier).loginWithFacebook();
            }, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/facebook.svg"),
                Text("Login with facebook")
              ],
            )
            ),
            TextButton(onPressed: ()async{
              await ref.read(authStateProvider.notifier).loginWithGoogle();
            }, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/google.svg"),
                Text("Login with Google")
              ],
            )
            )
          ],
        ),
      ),
    ); 
  }

}