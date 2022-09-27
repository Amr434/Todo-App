import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/shared/styles/them.dart';

class InputForm extends StatelessWidget {
  final String title;
  final String hint;
  double siz=200;
  Color ?bordercolor;
  FormFieldValidator<String> ?validator;
  Widget ?widget;
   TextEditingController? controller =TextEditingController();
   InputForm({
     Key? key,required this.title,required this.hint,this.controller,this.widget,this.validator,
     required this.siz,
     this.bordercolor=Colors.grey

   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var size=MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height*.016),
      width: double.infinity,


      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: titlestyle(size.height*.025),),
          SizedBox(height: size.height*.02,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width*.02),
            width: double.infinity,
            height: siz,
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(size.width*.03),
              border: Border.all(
                width: 2,
                color:bordercolor!
              )
            ),
            child:Row(
              children: [
                Expanded(
                  child: TextFormField(

                    obscuringCharacter: '0',
                    validator: validator,
                    readOnly: widget==null?false:true,
                    autofocus: false,
                    controller:controller ,

                    decoration:InputDecoration(

                      focusedErrorBorder: InputBorder.none,


                       border: InputBorder.none,
                      hintText: hint,
                      hintStyle: GoogleFonts.aBeeZee(
                        color: Colors.grey[400]
                      ),

                    ) ,

                  ),
                ),
                if(widget==null)
                  Container()
                else
                  Container(
                    child: widget,
                  )
              ],
            ) ,
          )

        ],
      ),
    );
  }
}
