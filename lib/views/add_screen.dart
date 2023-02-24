import 'package:firebase_flutter/models/note.dart';
import 'package:firebase_flutter/services/api_service.dart';
import 'package:firebase_flutter/views/notes_cont.dart';
import 'package:firebase_flutter/views/values/colors.dart';
import 'package:firebase_flutter/views/values/strings.dart';
import 'package:firebase_flutter/views/widgets/rounded_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddItemScreen extends StatelessWidget {
  AddItemScreen({Key? key}) : super(key: key);


  Future post(Note note)async{
    var response = await ApiService().postNote(note);
    if(response.statusCode == 200){
      print('success');
    }
  }




  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          color: primaryColor,
          padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(onPressed: (){
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (_){
                          return const NotesContainer();
                        }
                    )
                );
              }, icon: const Icon(Icons.keyboard_backspace)),
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
              const Expanded(
                child: SizedBox(),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
