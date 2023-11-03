import 'package:flutter/material.dart';
import 'package:ozora/module/create_task/view/create_task_view.dart';
import 'package:ozora/state_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateTaskController extends State<CreateTaskView>
    implements MvcController {
  static late CreateTaskController instance;
  late CreateTaskView view;
  @override
  void initState() {
    super.initState();
    instance = this;
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  final formKey = GlobalKey<FormState>();
  final textEditingController = TextEditingController();

  String? name;
  String? description;

  bool isLoading = false;

  User? user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;
  Future createTask({required String? name}) async {
    await db.collection('task').add({'name': name, 'description': description});
  }
}
