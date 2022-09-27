import 'dart:convert';


import 'package:get/get.dart';
import 'package:todo_task/models/task.dart';
import 'package:todo_task/shared/Network/local/helper/Sqlhelper2.dart';
import 'package:todo_task/shared/Network/local/helper/sqlHelper.dart';

class TaskControler extends GetxController{
    List<TaskModel>tasks=[];

@override
void onReady(){
 super.onReady();
}
  Future<void> Addtask(TaskModel? model) async{
   await  Sqlhelper.insert(model!).then((value)  async{
    await getdata();

   }

   );

  }

 static List<Map<String,dynamic>> tasklist=[];



  getdata() async{

List<Map<String,dynamic>> x= await Sqlhelper.getdata();
tasks =[];
x.forEach((element) {
  tasks.add(TaskModel.fromjson( jsonDecode(jsonEncode(element))));
});

update();
  }
  void delete(TaskModel model){
  Sqlhelper.delete(model).then((value) {
      getdata();
  });
  }

  void Update(int id) async{
   await Sqlhelper.update(id).then((value) {
     getdata();
   });
  }



}