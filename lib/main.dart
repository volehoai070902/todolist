import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/log/logger_custom.dart';
import 'package:todo_list/state/auth/provider/is_logged_in_provider.dart';
import 'package:todo_list/views/components/loading/loading_screen.dart';
import 'package:todo_list/state/providers/is_loading_provider.dart';
import 'package:todo_list/views/login/login_view.dart';
import 'package:todo_list/views/main/main_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,);
  runApp(
    ProviderScope(child: const MyApp())
    );
}

class MyApp extends ConsumerWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Consumer(
        builder: (context, ref, child){
          ref.listen<bool>(isLoadingProvider, (_, isLoading) {
            
            if(isLoading){
              LoggerCustom.instance().f(isLoading);
              LoadingScreen.instance().show(
                context: context
              );
            }else{
              LoadingScreen.instance().hide();
            }
           });
          
          final isLoggedIn = ref.watch(isLoggedInProvider);
          
          if(isLoggedIn){
            return MainView();
          }else{
            return LoginView();
          }
        }, 
      ),
    );
  }
}


