import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_task/models/task.dart';
import 'package:todo_task/shared/Network/local/controler/controlers.dart';
import 'package:todo_task/shared/Network/local/helper/Sqlhelper2.dart';
import 'package:todo_task/shared/component/inputforfield.dart';
import 'package:todo_task/shared/constant/appconstant.dart';
import 'package:todo_task/shared/styles/them.dart';
import '../shared/component/button.dart';
import 'home.dart';


class AddTask extends StatefulWidget {
  
  const AddTask({Key? key}) : super(key: key);
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  late DateTime _selecteddate;
 late String _enddate;
  late String _startdate;
  late int _selectedremind;
  late String _selectedRepeat;
  List<int>remindlist=[
    5,10,15,20
  ];
  List<String> Repeatlist=[
    "None",
    "Daily",
    "Monthly",
    "Weekly"
  ];
  int checked=0;
  List<Color>checkcolor=[
    Appcolor.bluishcolor,
    Colors.pink,
    Appcolor.yellowcolor
  ];
  late TextEditingController  _titlecontroler;
  late TextEditingController  _notecontroler;
  GlobalKey<FormState>keyform=GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selecteddate=DateTime.now();
    _startdate =DateFormat("hh:mm a").format(DateTime.now());
    _enddate='11:5';
    _selectedremind=5;
    _selectedRepeat="None";
    _titlecontroler=TextEditingController();
    _notecontroler=TextEditingController();
  }
  bool isvalidtitle=true;

  bool isvalidnote=true;

  @override
  Widget build(BuildContext context) {

    var size=MediaQuery.of(context).size;
    var heigt=size.height*.07;
    if(size.height>800){
      heigt=800;
    }
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Get.to(HomePage(),
              transition: Transition.fadeIn
            );
          },
          child: Icon(Icons.arrow_back_ios,size:size.width*.05 ,color: Appcolor.bluishcolor,),

        ),
        actions: [
          GestureDetector(
            onTap: (){

            },
              child: Icon(Icons.person)
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width*.04),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: keyform,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add Task',style: headerstyle(size.width*.05),

                ),
                InputForm(
                  bordercolor: isvalidtitle?Colors.grey: Colors.red,
                  siz:  isvalidtitle?heigt:size.height*.09,
                  title: 'Title', hint: "enter title",
                  controller: _titlecontroler,
                  validator: (String?value ){
                  if(value!.isEmpty){
                    return "Must not be null";
                  }
                  return null;

                  },

                ),
                InputForm(
                  controller: _notecontroler,
                    bordercolor: isvalidnote? Colors.grey:Colors.red,
                    siz:   isvalidnote?heigt:size.height*.09,
                    title: 'Note', hint: "enter note",
                  validator: (String ? value){
                    if(value!.isEmpty){  return "must not be empty";}
                   return null;
                  },

                ),
                InputForm(
                  siz: heigt,
                  title: 'Date', hint: DateFormat.yMd().format(_selecteddate),
                  widget: IconButton(
                    onPressed: ()async{
                  await  _showdatepicker();
                    },
                    icon:Icon(Icons.calendar_today_outlined,color: Colors.grey,)
                  ),
                ),
                Row(
                  children: [
                    Expanded(

                        child:
                        InputForm(
                          siz: heigt,
                          title: 'Start Time',hint: _startdate,widget: IconButton(
                          onPressed: ()async{
                            _showtimepicker(true);

                          },
                          icon: Icon(Icons.access_time_outlined,color: Colors.grey,),
                        ),)
                    ),
                    SizedBox(width: size.width*.02,),
                    Expanded(
                        child:
                        InputForm(
                          siz:heigt,
                          title: 'End Time',
                          hint:_enddate,
                          widget: IconButton(
                             onPressed: () {
                               _showtimepicker(false);
                             },
                            icon: Icon(Icons.access_time_outlined,color: Colors.grey,),
                          ),

                        ),

                    )
                  ],
                ),
                InputForm(
                  siz: heigt,
                  title: 'Remind', hint: '${_selectedremind } minutes early',
                  widget: DropdownButton(
                    items:remindlist.map<DropdownMenuItem<String>>(
                            (e) {
                              return DropdownMenuItem<String>(
                                value: e.toString(),
                                child: Text(e.toString()),
                              );

                            }
                    ).toList(),

                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: size.width*.05,
                    iconEnabledColor: Appcolor.bluishcolor,
                    underline: Container(height: 0,),

                    style: GoogleFonts.aBeeZee(

                      color: Colors.white
                    ),
                    elevation: 4,
                    dropdownColor: Appcolor.bluishcolor,
                    onChanged: (String? value) {
                      setState(
                              (){
                        _selectedremind=int.parse(value!) ;
                      }
                      );
                  },
                    borderRadius: BorderRadius.circular(size.width*.01),

                  ),

                ),
                InputForm(
                  siz: heigt,
                  title: 'Repeat', hint: '${_selectedRepeat }',
                  widget: DropdownButton(
                    items:Repeatlist.map<DropdownMenuItem<String>>(
                            (e) {
                          return DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          );

                        }
                    ).toList(),

                    icon: Icon(Icons.keyboard_arrow_down),
                    iconSize: size.width*.05,
                    iconEnabledColor: Appcolor.bluishcolor,
                    underline: Container(height: 0,),

                    style: GoogleFonts.aBeeZee(

                        color: Colors.white
                    ),
                    elevation: 4,
                    dropdownColor: Appcolor.bluishcolor,
                    onChanged: (String? value) {
                      setState(
                              (){
                            _selectedRepeat=value!;
                          }
                      );
                    },
                    borderRadius: BorderRadius.circular(size.width*.01),

                  ),

                ),
                SizedBox(height: size.height*.01,),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text("Color",style: titlestyle(size.width*.04),),
                            SizedBox(height: size.height*.01,),
                            Wrap(
                              children: List.generate(3, (index) {
                                return GestureDetector(
                                  onTap: (){
                                    setState((){
                                      checked=index;
                                    }
                                    );
                                  },
                                  child: Padding(
                                    padding:  EdgeInsets.only(right: size.width*.02),
                                    child: CircleAvatar(


                                      radius: size.width*.04,
                                      backgroundColor: checkcolor[index],
                                      child:checked==index? Icon(Icons.check,color: Colors.white,):Container(),
                                    ),
                                  ),
                                );
                              }),
                            )

                        ],
                      ),
                    ),
                    Button(text: 'Create Task',ontap: (){
                      if(keyform.currentState!.validate()){


                        isvalidtitle=true;
                        isvalidnote=true;
                        addtask().then((value) {

                           Get.to(HomePage(home: 'home',));
                        });
                        ;
                      }

                      else if(_titlecontroler.text==''&&_notecontroler.text==''){
                        setState((){

                            isvalidtitle=false;
                            isvalidnote=false;
                        });
                      }
                      else if(_titlecontroler.text==''){
    setState((){
                        isvalidtitle=false;
                        isvalidnote=true;});
                      }
                      else if(_notecontroler.text==''){
    setState(() {
      isvalidtitle = true;
      isvalidnote = false;
    });
                      }

                    },)
                  ],
                ),
                SizedBox(height: size.height*.03,)

              ],
            ),
          ),
        ),
      ),
      
    );
  }
Future<void> addtask() async{
     await TaskControler().Addtask(

      TaskModel(

      color: checked,
      data: DateFormat.yMd().format(_selecteddate),
      note: _notecontroler.text,
      title: _titlecontroler.text,
      endtime: _enddate,
      startime: _startdate,
      remind: _selectedremind,
      repeat: _selectedRepeat,
      isComplated: 0,

  )
  );

}

  Future<DateTime?>_showdatepicker() async{
    DateTime? _picker= await
    showDatePicker(
     initialDatePickerMode:DatePickerMode.day,
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(215),
        lastDate: DateTime(2121)
    );
    if(_picker!=null){
      setState((){
        _selecteddate=_picker;
      });
    }
  }

  _showtimepicker(bool isStart) async{

      var picked= await showTimePicker(

          initialEntryMode: TimePickerEntryMode.input,

          context: context,
          initialTime: TimeOfDay(

              hour: int.parse(_startdate.split(":")[0]),
              minute: int.parse(_startdate.split(":")[1].split(" ")[0]),

          )
      );
       if(picked!=null) {
         if (isStart == true) {
           setState(() {
             _startdate = picked.format(context).toString();
           });
         }
         else if (isStart == false) {
           setState(() {
             _enddate = picked.format(context).toString();
           });
         }
       }


  }








  }




