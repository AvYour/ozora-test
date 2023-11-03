import 'package:flutter/material.dart';
import 'package:ozora/module/landing/view/landing_view.dart';
import 'package:ozora/state_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingController extends State<LandingView> implements MvcController {
  static late LandingController instance;
  late LandingView view;
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

  String? user;
  void saveName(String? user) async {
    final name = user;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name!);
  }
}
