import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// GetX Template Generator - fb.com/htngu.99
///

String home = 'Home';
String appname = "TacToe";

get token {
  var prefs = GetStorage();
  final String? action1 = prefs.read('token');
// // Obtain shared preferences.
//   final pref = await SharedPreferences.getInstance();
//   await pref.reload();
//   // Try reading data from the 'action' key. If it doesn't exist, returns null.
//   final String? action = pref.getString('token');
//
//   return action ?? action1 ?? "you" ;
  return action1 ?? "you" ;
}
get name  {
  var prefs = GetStorage();
  final String? action1 = prefs.read('name');

// // Obtain shared preferences.
//   final pref = await SharedPreferences.getInstance();
//   await pref.reload();
//   // Try reading data from the 'action' key. If it doesn't exist, returns null.
//   final String? action = pref.getString('token');
//
//   return action ?? action1 ?? "you" ;
  return action1 ?? "you" ;
}
get email  {
  var prefs = GetStorage();
  final String? action1 = prefs.read('email');

// // Obtain shared preferences.
//   final pref = await SharedPreferences.getInstance();
//   await pref.reload();
//   // Try reading data from the 'action' key. If it doesn't exist, returns null.
//   final String? action = pref.getString('token');
//
//   return action ?? action1 ?? "you" ;
  return action1 ?? "you" ;
}
get phone  {
  var prefs = GetStorage();
  final String? action1 = prefs.read('phone');

// // Obtain shared preferences.
//   final pref = await SharedPreferences.getInstance();
//   await pref.reload();
//   // Try reading data from the 'action' key. If it doesn't exist, returns null.
//   final String? action = pref.getString('token');
//
//   return action ?? action1 ?? "you" ;
  return action1 ?? "you" ;
}
get game {
  var prefs = GetStorage();
  final String? action1 = prefs.read('game');

// // Obtain shared preferences.
//   final pref = await SharedPreferences.getInstance();
//   await pref.reload();
//   // Try reading data from the 'action' key. If it doesn't exist, returns null.
//   final String? action = pref.getString('token');
//
//   return action ?? action1 ?? "you" ;
  return action1 ?? "you" ;
}
var _points = "".obs;
set points(value) => _points.value = value;
get points {
  var prefs = GetStorage();
  final String action1;
  if(_points.isEmpty) {
    action1 = prefs.read('points').toString();
    _points.value = action1??"";
  } else{
    action1 = _points.value;
  }

// // Obtain shared preferences.
//   final pref = await SharedPreferences.getInstance();
//   await pref.reload();
//   // Try reading data from the 'action' key. If it doesn't exist, returns null.
//   final String? action = pref.getString('token');
//
//   return action ?? action1 ?? "you" ;
  return action1 ?? "0" ;
}