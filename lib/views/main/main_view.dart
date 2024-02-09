import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/state/auth/provider/auth_state_provider.dart';

class MainView extends ConsumerWidget{
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Container(
          child: TextButton(
            onPressed: ()async{
              await ref.read(authStateProvider.notifier).logOut();
            },
            child: const Icon(Icons.logout),
          ),
          ),
        ),
    );
  }

}