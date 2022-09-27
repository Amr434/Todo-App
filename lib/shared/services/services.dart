import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
class ThemServices{
  final _box=GetStorage();
  final String _key='isDarkMode';
      setthemode(bool isdark)=>_box.write(_key, isdark);
  bool _loadThemode()=>_box.read(_key)??false;

  ThemeMode get Them=>_loadThemode()?ThemeMode.dark:ThemeMode.light;


  void swiththem(){
    Get.changeThemeMode(_loadThemode()?ThemeMode.light:ThemeMode.dark);
    setthemode(!_loadThemode());
  }
  bool isDarkmode(){
    return _box.read(_key)==true;
  }

}