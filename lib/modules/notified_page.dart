import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_task/shared/constant/appconstant.dart';
import 'package:todo_task/shared/styles/them.dart';

class NotifiedPage extends StatelessWidget {
  final String ?payload;
  const NotifiedPage({Key? key,required this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios,size: size.width*.05,),
        ),
        title: Center(child: Padding(
          padding:  EdgeInsets.only(right: size.width*.09),
          child: Text(payload!.split("|")[0],style: titlestyle(size.width*.04).copyWith(
            fontSize: size.width*.06
          ),),
        )),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        
        child: Center(
          child: Container(
            padding: EdgeInsets.all(size.width*.05),

            height: size.height*.7,
            width: size.width*.9,
            decoration: BoxDecoration(
              color: Appcolor.bluishcolor,
              borderRadius: BorderRadius.circular(size.width*.1)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Title",style: subheaderstyle(size.width*.06).copyWith(
                            color: Colors.white
                          ),),
                          SizedBox(width: size.width*.02,),
                          Icon(Icons.edit,color: Colors.white,)
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(left: size.width*.03,top: size.width*.03),
                        child: Text("Flutter",style: GoogleFonts.aleo(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                          fontSize: size.width*0.06
                        ),),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Description",style: subheaderstyle(size.width*.06).copyWith(
                              color: Colors.white
                          ),),
                          SizedBox(width: size.width*.02,),
                          Icon(Icons.description,color: Colors.white,)
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(left: size.width*.03,top: size.width*.02),
                        child: Text(payload!.split("|")[1].split("+")[0],style: GoogleFonts.aleo(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.bold,
                            fontSize: size.width*0.04
                        ),),
                      )
                    ],

                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Time",style: subheaderstyle(size.width*.06).copyWith(
                              color: Colors.white
                          ),),
                          SizedBox(width: size.width*.02,),
                        const  Icon(Icons.access_time_outlined,color: Colors.white,)
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(
                          left: size.width*.03,top: size.width*.03),
                          child: Text(payload!.split("|")[1].split("+")[1],style: GoogleFonts.aleo(

                            color: Colors.grey[400],
                            fontWeight: FontWeight.bold,
                            fontSize: size.width*0.05
                        ),),
                      )
                    ],
                  ),
                ),


              ],
            ),
          ),
          
          
        ),
        


      ),
    );
  }
}
