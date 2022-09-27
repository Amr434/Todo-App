import 'dart:async';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_task/models/task.dart';
import 'package:todo_task/shared/component/button.dart';
import 'package:todo_task/shared/component/task_tile.dart';
import 'package:todo_task/shared/constant/appconstant.dart';
import 'package:todo_task/shared/services/notification_services.dart';
import 'package:todo_task/shared/services/services.dart';
import 'package:todo_task/shared/styles/them.dart';

import '../shared/Network/local/controler/controlers.dart';
import 'addtask.dart';

class HomePage extends StatefulWidget {
   final String ?home;
  const HomePage({Key? key,this.home}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState(home);
}

class _HomePageState extends State<HomePage> {
  final String ?home;
  _HomePageState(this.home);
  late NotifyHelper notifyHelper;
  DateTime _selecteddate=DateTime.now();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    notifyHelper=NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();

  }

  @override
  Widget build(BuildContext context) {

    Get.find<TaskControler>().getdata();
    var size=MediaQuery.of(context).size;
    if(home=='home'){
      setState((){});
    }


    return Scaffold(

      appBar: AppBar(
        leading:
        GestureDetector(
          onTap: ()
          {
            setState((){
              ThemServices().swiththem();
            });

            NotifyHelper().displayNotification(
           title: "change mode",
             body:Get.isDarkMode?"LightMode active": "DarkMode active"
          );


          },
            child: Icon(Get.isDarkMode?Icons.nightlight_rounded:Icons.sunny,size: size.width*.05,)
        ),
        actions: [
          GestureDetector(
              onTap: ()
              {

              },
              child:  CircleAvatar(
                radius: size.width*.034,

                backgroundImage: NetworkImage(

                  'https://media.istockphoto.com/vectors/user-icon-people-icon-isolated-on-white-background-vector-vector-id1210939712?k=20&m=1210939712&s=612x612&w=0&h=xJqEPQnMiNofprbLXWdEtJQ75QL79lQ5N76J4JOdTIM=',))
          ),
          SizedBox(width: size.width*.02,)


        ],
      ),

     body: Column(
       children: [
       _taskbar(size),
         SizedBox(height: size.height*.02,),
         _taskdatebar(size),
         SizedBox(height: size.height*.02,),
         _showtasks(context),
       ],
     ),

    );
  }
  _showtasks(size){
    return GetBuilder<TaskControler>(
      builder: (controler){

        return  Expanded(
            child:ListView.builder(
              physics: BouncingScrollPhysics(),
            keyboardDismissBehavior:ScrollViewKeyboardDismissBehavior.onDrag ,
            itemCount: controler.tasks.length,
              itemBuilder: (BuildContext context, int index) {
              TaskModel task=controler.tasks[index];
              if(task.repeat=='Daily'){
                int hour=int.parse(task.startime!.split(":")[0]);
                int minutes=  int.parse(task.startime!.split(":")[1].split(" ")[0]);



                print(hour);
                print(minutes);
                NotifyHelper().scheduledNotification(hour,minutes,task);
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child:GestureDetector(
                          onTap: (){
                            _showbottomsheet(context,controler.tasks[index]);
                          },
                          child: TaskTile(task: controler.tasks[index])),
                    ),
                  ),
                );
              }
               else if(task.data==DateFormat.yMd().format(_selecteddate)){
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child:GestureDetector(
                          onTap: (){
                            _showbottomsheet(context,controler.tasks[index]);
                          },
                          child: TaskTile(task: controler.tasks[index])),
                    ),
                  ),
                );
              }
              else{
                return Container();
              }

              },
            ),

        );
      },
    );
  }
  _showbottomsheet(context ,TaskModel taskModel){
var size=MediaQuery.of(context).size;
    return Get.bottomSheet(
      isDismissible: false,
        Container(
          width: double.infinity,
          height:  taskModel.isComplated==0?size.height*.3:size.height*.2,
          color: Get.isDarkMode?Appcolor.darkheadercolor:Colors.white,

          child: GetBuilder<TaskControler>(
            builder: (controler){
              return  Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: size.width*.01),
                    width:size.width*.3,
                    height: size.height*.009,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius:BorderRadius.circular(
                            size.width*.1
                        )
                    ),
                  ),
                  Spacer(),
                  taskModel.isComplated==0?
                  _buttonsheet(context,color:Appcolor.bluishcolor,label: 'isCopmlated',isclose: false,
                      ontap: (){
                    controler.Update(taskModel.id!);
                    Get.back();

                      }):Container(),
                  taskModel.isComplated==0?SizedBox(height: size.width*.03,):Container(),

                  _buttonsheet(context,color: Colors.red[300]!,label: 'delete Task',isclose: false,
                      ontap: (){
                        controler.delete(taskModel);
                        Get.back();
                      }),
                  SizedBox(height: size.height*.04,),
                  _buttonsheet(context,color: Appcolor.bluishcolor,label: 'close',isclose: true,
                      ontap: (){
                        Get.back();
                      }),
                  SizedBox(height: size.width*.01,)

                ],
              );
            },
          ),

      )
    );
  }
  _buttonsheet(context,{required Color color, required String label,bool isclose=false,required Function ontap}){

    var size =MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (){
        ontap();
      },
      child: Container(
         width: size.width*.9,
        height: size.height*.06,

        decoration: BoxDecoration(
            color: isclose?Colors.transparent :color,
          borderRadius: BorderRadius.circular(size.width*.03),
          border:Border.all(
            color: isclose?Colors.grey[600]!:Colors.transparent,

          )
        ),
        child: Center(
          child: Text(
            label,
            style: titlestyle(size.width*.04).copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: isclose?Get.isDarkMode?Colors.white:Colors.black54:Colors.white
            ),
          ),
        ),

      ),
    );
  }
  _taskbar(size){
    return   Container(
      padding: EdgeInsets.symmetric(horizontal: size.width*.05),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat. yMMMMd().format(DateTime.now()),style: subheaderstyle(size.width*.04),),
                SizedBox(height: size.height*.01,),
                Text('Today',style: headerstyle(size.width*.06))
              ],
            ),
          ),
          Button(text: '+ Add Task',ontap: (){
            Get.to(AddTask(),
                transition: Transition.fadeIn
            );
          },)
        ],

      ),
    );
  }

  _taskdatebar(size){
    return Container(
      margin: EdgeInsets.only(left: size.width*.04),
      child: DatePicker(

        DateTime.now(),
        height: size.height*.13,
        width: size.width*.2,

        selectedTextColor: Colors.white,
        initialSelectedDate: DateTime.now(),
        selectionColor: Appcolor.bluishcolor,
        dateTextStyle: GoogleFonts.aBeeZee(
            color: Colors.grey,
            fontSize: size.height*.023,
            fontWeight: FontWeight.bold
        ),
        monthTextStyle: GoogleFonts.aBeeZee(
            color: Colors.grey,
            fontSize: size.height*.0156,
            fontWeight: FontWeight.bold
        ),
        dayTextStyle: GoogleFonts.aBeeZee(
            color: Colors.grey,
            fontSize: size.height*.024,
            fontWeight: FontWeight.bold
        ),

        onDateChange: (date){
          setState((){
            _selecteddate=date;
          });

        },

      ),
    );
  }
}
