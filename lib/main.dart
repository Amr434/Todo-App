import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_task/shared/Network/local/controler/controlers.dart';
import 'package:todo_task/shared/Network/local/helper/Sqlhelper2.dart';
import 'package:todo_task/shared/services/notification_services.dart';

import 'package:todo_task/shared/services/services.dart';
import 'package:todo_task/shared/styles/them.dart';

import 'modules/home.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent
  ));

  await  GetStorage.init();
  await Sqlhelper.intidb();
 await Get.put(TaskControler());





  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo ',
      theme:Themes.light,
      themeMode: ThemServices().Them,
      darkTheme: Themes.dark,
      home: const HomePage(),
    );
  }
}

