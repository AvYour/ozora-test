import 'package:flutter/material.dart';
import 'package:ozora/module/edit_task/view/edit_task_view.dart';
import 'package:ozora/state_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditTaskController extends State<EditTaskView> implements MvcController {
  static late EditTaskController instance;
  late EditTaskView view;
  @override
  void initState() {
    super.initState();
    instance = this;
  }

  @override
  void dispose() {
    taskNameEditingController.dispose();
    descEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  final formKey = GlobalKey<FormState>();
  var taskNameEditingController = TextEditingController();
  var descEditingController = TextEditingController();
  String? name = '';
  String? description = '';

  bool isLoading = false;

  User? user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;
  Future updateTask(
      {required String? taskId,
      required String? taskName,
      String? taskDesc}) async {
    db
        .collection('task')
        .doc(taskId)
        .update({'name': taskName, 'description': taskDesc});
  }
}
