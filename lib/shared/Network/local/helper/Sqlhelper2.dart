import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:todo_task/models/task.dart';

class Sqlhelper{

  static Database? _database ;
  static final String _tablename='tasks';
  static final int _version=1;

  static Future<void>intidb() async {
    if(_database!=null){
      return ;
    }
    else {
      openDatabase('todoapp.db',
          version: 1,
          onCreate: (database, version) async
          {
            print("craeted database");
            await database.execute(
                '''CREATE TABLE '$_tablename'(
                  id INTEGER PRIMARY KEY AUTOINCREMENT ,
                  title TEXT NOT NULL, 
                 note TEXT NOT NULL, 
                 date TEXT NOT NULL, 
                   startime TEXT NOT NULL , 
                   endtime TEXT NOT NULL ,
                   remind INTEGER NOT NULL, 
                     color INTEGER NOT NULL,
                    repeat TEXT NOT NULL,
                   isComplated INTEGER  NOT NULL
                        )
                        '''
            )
                .then((value) {
              print("table craeted");
            }
            ).catchError((error) {
              print(error.toString());
            });
          },
          onOpen: (database) {
            print("data base opend");
          }
      ).then((value) {
       _database = value;
      });
    }
  }
static  Future insert(TaskModel model) async{

    await _database!.transaction((txn) {

      return txn.rawInsert(
          "INSERT INTO $_tablename(title,date,repeat,note,startime,endtime,remind,isComplated,color)VALUES(' ${model.title}','${model.data}','${model.repeat}','${model.note}','${model.startime}','${model.endtime}','${model.remind}','${model.isComplated}','${model.color}')").
      then((value) {
        print("$value inserted");

      }).catchError((error){
        print(error.toString());

      });



    });

  }

 static getdata()  async{
     return await _database!.transaction((txn) {
       return  txn.rawQuery("SELECT * FROM $_tablename").then((value) {
        return value;
       });
     });

  }

  static Future delete(TaskModel taskModel) async{
    return _database!.transaction((txn) {
      return  txn.delete("$_tablename ", where: 'id=?',whereArgs: [taskModel.id]).then((value) {

      }).catchError((s){
        print(s);
      });
    });
  }
  static Future update(int id){
    return _database!.transaction((txn) => txn.rawUpdate('''
    
    UPDATE $_tablename 
    SET isComplated=?
    where id=?
    ''',[1,id]));

  }




}