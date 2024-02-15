
import 'package:flutter/material.dart';


class SignUpView extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: size.width,
        height: size.height,
        child: GestureDetector(
          onTap: (){
            print("hello");
          },
          child: Container(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                Container(
                  width: size.width,
                  child: Expanded(flex: 1,child: Container(child: Text("Hello")))),
                Container(
                  width: size.width,
                  child: Expanded(flex:1,child: Container(child: Text("Hello")))),
              ],
            ),
          ),
        ),
      ),
    );
  }

}