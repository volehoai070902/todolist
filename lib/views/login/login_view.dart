import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/log/logger_custom.dart';

import 'package:todo_list/state/auth/provider/auth_state_provider.dart';
import 'package:todo_list/views/login/login_with_email_view.dart';
import 'package:todo_list/views/signup/sign_up_with_email.dart';

final items = ['Sign up with email', 'Login with email'];

final overlayProvider = Provider((ref) => OverlayPortalController());

class LoginView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          width: 100,
          height: 100,
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          final isOpen = ref.read(overlayProvider).isShowing;
          LoggerCustom.instance().i(isOpen);
          if (isOpen) {
            ref.read(overlayProvider).toggle();
          }
        },
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: size.width,
                  child: SvgPicture.asset("assets/images/study.svg"),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                              side: BorderSide(color: Colors.black)),
                          onPressed: () async {
                            await ref
                                .read(authStateProvider.notifier)
                                .loginWithFacebook();
                          },
                          child: Container(
                            width: size.width * 0.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset("assets/icons/facebook.svg"),
                                SizedBox(width: 10),
                                CustomText(
                                  text: 'Login with facebook',
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              side: BorderSide(color: Colors.black)),
                          onPressed: () async {
                            await ref
                                .read(authStateProvider.notifier)
                                .loginWithGoogle();
                          },
                          child: Container(
                            width: size.width * 0.5,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset("assets/icons/google.svg"),
                                SizedBox(width: 10),
                                CustomText(
                                  text: 'Login with Google',
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: Container(
                  height: size.height * 0.09,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: CustomDropDown(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  const CustomText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${text}',
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}

class CustomDropDown extends ConsumerWidget {
  const CustomDropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final _tooltipController = ref.watch(overlayProvider);
    return OverlayPortal(
      controller: _tooltipController,
      overlayChildBuilder: (BuildContext context) {
        return Positioned(
          bottom: size.height * 0.08,
          left: size.width * 0.25,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2),
                  ),
                ]),
            width: size.width * 0.5,
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      _tooltipController.toggle();
                      Navigator.of(context)
                          .push(_createRoute(page: SignUpView()));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.mail),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(text: "Sign up with email"),
                      ],
                    )),
                TextButton(
                    onPressed: () {
                      _tooltipController.toggle();
                      Navigator.of(context)
                          .push(_createRoute(page: LoginWithEmailView()));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.login),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(text: "login with email"),
                      ],
                    ))
              ],
            ),
          ),
        );
      },
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          child: TextButton(
            onPressed: () {
              _tooltipController.toggle();
            },
            child: const Text(
              'Continue with more options',
              style: TextStyle(fontSize: 13, decoration: TextDecoration.underline),
            ),
          ),
        ),
      ),
    );
  }
}

Route _createRoute({required Widget page}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}




// Container(
//                 child: Expanded(
//                     flex: 2, child: SvgPicture.asset("assets/images/study.svg")),
//               ),
//               Container(
//                 child: Expanded(
//                     flex: 1,
//                     child: Container(
//                       width: size.width,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                         TextButton(
//                             style: TextButton.styleFrom(
//                               side: BorderSide(color: Colors.black)
//                             ),
//                             onPressed: () async {
//                               await ref
//                                   .read(authStateProvider.notifier)
//                                   .loginWithFacebook();
//                             },
//                             child: Container(
//                               width: size.width * 0.5,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   SvgPicture.asset("assets/icons/facebook.svg"),
//                                   SizedBox(width: 10),
//                                   CustomText(text: 'Login with facebook',)
//                                 ],
//                               ),
//                             )),
//                         SizedBox(height: 10,),
//                         TextButton(
//                           style: TextButton.styleFrom(
//                               side: BorderSide(color: Colors.black)
//                             ),
//                             onPressed: () async {
//                               await ref
//                                   .read(authStateProvider.notifier)
//                                   .loginWithGoogle();
//                             },
//                             child: Container(
//                               width: size.width * 0.5,
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   SvgPicture.asset("assets/icons/google.svg"),
//                                   SizedBox(width: 10),
//                                   CustomText(text: 'Login with Google',)
//                                 ],
//                               ),
//                             ))
//                       ]),
//                     )
//                   ),
//               ),
//                 Container(
//                   child: Expanded(
//                     flex: 1,
//                     child: Container(
//                       child: Align(
//                         alignment: Alignment.topCenter,
//                         child: const CustomDropDown()))),
//                 )