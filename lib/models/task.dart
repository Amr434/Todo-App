class TaskModel{
  int ?id;
  String ?title;
  String ?note;
  int? isComplated;
  String ?data;
  String? startime;
  String? endtime;
  int? color;
  int ?remind;
  String ?repeat;
  TaskModel({
  required this.color,
  required this.endtime
  ,required this.startime,
  required this.remind,
  required this.isComplated,
    required this.data,
    required this.repeat,
    required this.note,
    required this.title,
     this.id
  });

  factory TaskModel.fromjson(Map<String,dynamic>json){

    return TaskModel(
      id: json['id'],
        color: json['color'],
        endtime: json['endtime'],
        startime:json['startime'],
        remind: json['remind'],
        isComplated: json['isComplated'],
        data: json['date'],
        repeat:json['repeat'],
        note:json['note'],
        title: json['title'],


    );


  }
  Map<String,dynamic>tojson(){
    return{
      'id':this.id,
      'title':this.title,
      'note':this.note,
      'data':this.data,
      'isComplated':this.isComplated,
      'repeat':this.repeat,
      'remind':this.remind,
      'startime':this.startime,
      'endtime':this.endtime,
      'color':this.color,


    };
  }
}
