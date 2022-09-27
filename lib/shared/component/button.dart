import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/shared/constant/appconstant.dart';

class Button extends StatelessWidget {
  final Function()?ontap;
  final String text;
  const Button({Key? key,required this.text,
    required this.ontap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width*.06,
          vertical: size.width*.04
            
        ),
        decoration: BoxDecoration(
          color: Appcolor.bluishcolor,
          borderRadius: BorderRadius.circular(size.width*.03)
          
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
           fontFamily: GoogleFonts.aBeeZee().fontFamily,
            fontWeight: FontWeight.bold
          ),
        ),
        
      ),
    );
  }
}
