import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
   final VoidCallback onSave;
  final VoidCallback onCancel;
   const DialogBox({
    super.key,
  required this.controller,
  required this.onSave,
  required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
         //get user input
         TextField(
          controller: controller,
          decoration:InputDecoration(border: OutlineInputBorder(),
          hintText:"add a new task" 
          ) ,
         ),


        //button -> save + cancle
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          ///save button
          MyButton(text: "save",onpressed: onSave),
          const SizedBox(width: 8,),
 

          //cancle buton
            MyButton(text: "cancle", onpressed: onCancel),

          ],
        ),



        ],
        ),
        
      ),
    );
  }
}