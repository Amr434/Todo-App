
import 'package:sqflite/sqflite.dart';
import 'package:todo_task/models/task.dart';
import 'package:get/get.dart';
class Dbhelper {

  static   Database ?_database;
   static const int _version=1;
  static const String tablname='task';

  static Future<void> init() async{

    if(_database!=null){
      return;
    }
    else{
      try{
    String x=   await  getDatabasesPath();

      String path=x+'Todoapps.db';
      _database=await openDatabase(
          path,
        version: _version,


        onCreate: (Database db,int version){
             _database?.execute(
              "CREATE TABLE $tablname("
                  "id INTEGER PRIMARY KEY AUTOINCREMENT NOTNULL,"
                  "title STRING, "
                 " note TEXT, "
                 "date STRING, "
                  " startime STRING , "
                  " endtime STRING, "
                  " remind INTEGER, "
                     "color INTEGER ,"
                   " repeat STRING ,"
                   "isComplated INTEGER)"
            ).then((value) {
              print("created table");

             }
             ).catchError((e){
               print(e.toString());
             });

        },
        onOpen: (Database){
            print("opend database");
        }


      ).then((value){
        print("database created");
      }).catchError((e){
        print("**************");
        print(e.toString());
      });

    }
    catch(e){
        print(e.toString());

    }

   }

  }

 static Future<dynamic> insert(TaskModel? model) async{

    return await _database?.insert(tablname, model!.tojson())??1;


  }

 static Future<dynamic>getdb(){
    print("db");
    return getdatebase(_database);
  }

 static Future<dynamic> getdatebase(database) async {


    await  database!.rawQuery("SELECT * FROM task ").then((value) {

      value.forEach((element) {
        print(element);
      }
       );

    });

  }





}