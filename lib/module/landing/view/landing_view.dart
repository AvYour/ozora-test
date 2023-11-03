import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ozora/core.dart';
import 'package:ozora/module/landing/controller/landing_controller.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LandingView extends StatefulWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  State<LandingView> createState() => LandingController();
  Widget build(context, LandingController controller) {
    controller.view = this;
    return Scaffold(
        backgroundColor: HexColor('#164863'),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text('T.',
                    style: TextStyle(
                        fontSize: 80,
                        fontFamily: 'Agbalumo',
                        color: HexColor('#427D9D'))),
              ),
              GradientText(
                'To-Do App',
                style: const TextStyle(
                  fontSize: 50.0,
                ),
                colors: [HexColor("#9BBEC8"), HexColor('#DDF2FD')],
              ),
              TextField(
                onChanged: (value) {
                  controller.user = value;
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Enter Your Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  child:
                      const Text('Get Started', style: TextStyle(fontSize: 25)),
                  onPressed: () {
                    controller.saveName(controller.user);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeView()),
                    );
                  },
                ),
              ),
            ],
          ),
        )));
  }
}
