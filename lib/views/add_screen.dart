import 'package:firebase_flutter/models/note.dart';
import 'package:firebase_flutter/services/api_service.dart';
import 'package:firebase_flutter/views/notes_cont.dart';
import 'package:firebase_flutter/views/values/colors.dart';
import 'package:firebase_flutter/views/values/strings.dart';
import 'package:firebase_flutter/views/widgets/rounded_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddItemScreen extends StatelessWidget {
  late bool forAdd;
  Note? note;
  AddItemScreen({Key? key,required this.forAdd,this.note}) : super(key: key);


  Future post(Note note)async{
    var response = await ApiService().postNote(note);
    if(response.statusCode == 200){
      print('success');
    }
  }




  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();



  List<Widget> forAdding(BuildContext context){
    return [

      IconButton(onPressed: (){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (_){
                  return const NotesContainer();
                }
            )
        );
      }, icon: const Icon(Icons.keyboard_backspace)),
      SizedBox(height: 50.h,),
      RoundedTextField(
        label: titleString,
        controller: titleController,
      ),
      SizedBox(height: 20.h,),
      RoundedTextField(
        hint: descriptionString,
        controller: contentController,
        minLines: 17,
      ),

      SizedBox(height: 50.h,),

      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: ()async{
            if(contentController.text.isNotEmpty && titleController.text.isNotEmpty){
              Note note = Note(title: titleController.text, content: contentController.text);
              await post(note);
              contentController.text = "";
              titleController.text = "";
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: itemBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(addString),
          ),
        ),
      )
    ];
  }
  
  List<Widget> forShowing(BuildContext context){
    return [
      IconButton(onPressed: (){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (_){
                  return const NotesContainer();
                }
            )
        );
      }, icon: const Icon(Icons.keyboard_backspace)),
      SizedBox(height: 20.h,),
      Text(titleString,style: TextStyle(fontSize: 20.sp,color: itemBackgroundColor)),
      SizedBox(height: 20.h,),
      Text(note!.title,style: TextStyle(fontSize: 25.sp,color: secondaryColor),),
      SizedBox(height: 20.h,),
      Text(descriptionString,style: TextStyle(fontSize: 20.sp,color: itemBackgroundColor)),
      SizedBox(height: 20.h,),
      SizedBox(
        width: double.infinity,
        child: Text(note!.content,style: TextStyle(fontSize: 25.sp,color: secondaryColor)),
      ),
      SizedBox(height: 20.h,),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: primaryColor,
          height: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 5.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: forAdd?forAdding(context):forShowing(context),
            ),
          ),
        ),
      ),
    );
  }
}
