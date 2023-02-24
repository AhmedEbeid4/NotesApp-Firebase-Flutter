import 'package:firebase_flutter/models/note.dart';
import 'package:firebase_flutter/views/values/colors.dart';
import 'package:firebase_flutter/views/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteItem extends StatelessWidget {
  late VoidCallback onDelete;
  late VoidCallback onClick;
  late Note item;
  NoteItem({Key? key,required this.item,required this.onClick,required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
            color: itemBackgroundColor,
            border: Border.all(color: thirdColor,width: 3),
          borderRadius: BorderRadius.circular(30)
        ),
        height: 80.h,
        margin: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 4.sp),

        child: Row(
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Image(
                    width: 60,
                    height: 60.h,
                    image: const AssetImage(noteIconPath),
                  )),
              SizedBox(width: 7.w,),
              Text(item.title, style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: thirdColor
              ),),
              const Expanded(flex: 1, child: SizedBox()),

              IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete,color: thirdColor,)
              )
            ]),
      ),
    );
  }
}
