

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/shared/constant/appconstant.dart';
import "package:get/get.dart";
import 'package:todo_task/shared/services/services.dart';

class Themes{
  static final  ThemeData light=ThemeData(

    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
      appBarTheme: AppBarTheme(

        iconTheme: IconThemeData(
            color: Colors.black
        ),
         titleTextStyle: TextStyle(
           color: Colors.black
         ),
          elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.dark
            ),
          color:Colors.white,


      ),
      primaryColor: Appcolor.bluishcolor,
      brightness: Brightness.light
  );

  static final ThemeData dark=ThemeData(

      appBarTheme: AppBarTheme(

        iconTheme: IconThemeData(
          color: Colors.white
        ),
          titleTextStyle: TextStyle(
              color: Colors.white
          ),
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarIconBrightness: Brightness.light
          ),
          color: Appcolor.darkheadercolor
      ),
      scaffoldBackgroundColor: Appcolor.darkheadercolor,

      primaryColor: Appcolor.darkGreycolor,
      brightness: Brightness.dark
  );
}

TextStyle  headerstyle(double size){
    return GoogleFonts.aBeeZee(
      //color: ThemServices().isDarkmode()?Colors.white:Colors.black,
      fontSize:size ,
      fontWeight: FontWeight.bold
    );
}
TextStyle  subheaderstyle(double size){

  return GoogleFonts.aBeeZee(

      color: ThemServices().isDarkmode()?Colors.grey[300]:Colors.grey,
      fontSize:size ,

      fontWeight: FontWeight.bold,

  );
}
TextStyle titlestyle(double size){

  return GoogleFonts.aBeeZee(

    color: ThemServices().isDarkmode()?Colors.grey[300]:Colors.black54,
    fontSize:size ,

    fontWeight: FontWeight.w400,

  );
}