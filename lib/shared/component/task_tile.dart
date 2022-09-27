
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/models/task.dart';
import 'package:todo_task/shared/constant/appconstant.dart';

class TaskTile extends StatelessWidget {
  final TaskModel? task;
  TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Container(

      padding:
      EdgeInsets.symmetric(horizontal: size.width*.05),
      width: size.width,
      margin: EdgeInsets.only(bottom:size.width*.03 ),
      child: Container(
        padding: EdgeInsets.all(size.width*.04),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width*.04),
          color: _getBGClr(task?.color??0),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task?.title??"",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: size.width*.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: size.width*.03,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size: size.width*.045,
                    ),
                    SizedBox(width: size.width*.02),
                    Text(
                      "${task!.startime} - ${task!.endtime}",
                      style: GoogleFonts.lato(
                        textStyle:
                        TextStyle(fontSize: size.width*.03, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height*.01),
                Text(
                  task?.note??"",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: size.height*.019, color: Colors.grey[100]),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: size.height*.09,
            width: size.width*.0017,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,

            child: Text(
              task!.isComplated == 1 ? "COMPLETED" : "TODO",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: size.width*.028,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return Appcolor.bluishcolor;
      case 1:
        return Colors.pink;
      case 2:
        return Appcolor.yellowcolor;
      default:
        return Appcolor.bluishcolor;
    }
  }
}