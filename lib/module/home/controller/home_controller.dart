import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ozora/core.dart';
import 'package:ozora/state_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends State<HomeView> implements MvcController {
  static late HomeController instance;
  late HomeView view;
  @override
  void initState() {
    super.initState();
    getPreferences();
    instance = this;
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  final formKey = GlobalKey<FormState>();
  final textEditingController = TextEditingController();

  final db = FirebaseFirestore.instance;

  String user = '';
  void getPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name');

    setState(() {
      if (name != null) {
        user = name;
      } else {
        user = 'Name not found in SharedPreferences';
      }
    });
  }

  void setPreferences(
      String taskId, String taskName, String description) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('taskId', taskId);
    await prefs.setString('taskName', taskName);
    prefs.setString('description', description);
  }
}
