import 'package:firebase_flutter/views/add_screen.dart';
import 'package:firebase_flutter/views/values/colors.dart';
import 'package:firebase_flutter/views/values/strings.dart';
import 'package:firebase_flutter/views/widgets/note_item_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/note.dart';
import '../services/api_service.dart';

class NotesContainer extends StatefulWidget {
  const NotesContainer({Key? key}) : super(key: key);

  @override
  State<NotesContainer> createState() => _NotesContainerState();
}

class _NotesContainerState extends State<NotesContainer> {
  int _firstLength=-1;
  List<Note>? notes = [];

  void _getNotes() async {
    notes = await ApiService().getNotes();
    if(notes != null){
      _firstLength=notes!.length;
    }
    setState(() {});
  }
  void _deleteNote(int index)async{
    var response = await ApiService().deleteNote(notes![index]);
    if(response != null && response.statusCode == 200){
      print('success');
      notes?.removeAt(index);
      setState(() {});
    }

  }
  @override
  void initState() {
    if (notes == null || notes!.isEmpty) {
      _getNotes();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          color: primaryColor,
          child: _firstLength == -1
              ? const Center(
                  child: CircularProgressIndicator(
                    color: itemBackgroundColor,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      const Text(
                        yourNotesText,
                        style: TextStyle(fontSize: 28, color: secondaryColor),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: notes?.length,
                        itemBuilder: (context, index) {
                          var item = NoteItem(
                              item: notes![index],
                              onClick: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (_) {
                                  return AddItemScreen(
                                    forAdd: false,
                                    note: notes![index],
                                  );
                                }));
                              },
                              onDelete: (){
                                _deleteNote(index);
                              });
                          if (index == notes!.length - 1) {
                            return Column(
                              children: [
                                item,
                                SizedBox(
                                  height: 70.h,
                                )
                              ],
                            );
                          }
                          return item;
                        },
                      ),
                    ],
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (_) {
              return AddItemScreen(
                forAdd: true,
              );
            }));
          },
          backgroundColor: secondaryColor,
          splashColor: amberAccent,
          child: Icon(
            Icons.add,
            color: primaryColor,
            size: 25.sp,
          )),
    );
  }
}
