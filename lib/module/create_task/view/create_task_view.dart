import 'package:flutter/material.dart';
import 'package:ozora/module/create_task/controller/create_task_controller.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';

import '../../home/view/home_view.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({Key? key}) : super(key: key);

  @override
  State<CreateTaskView> createState() => CreateTaskController();
  Widget build(context, CreateTaskController controller) {
    controller.view = this;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: const Text('Create Task',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.black)),
        centerTitle: true,
      ),
      body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 6),
          children: [
            Form(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Detail Task',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Task Name',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: HexColor('#808080'))),
                      TextSpan(
                          text: '*',
                          style: TextStyle(
                              fontSize: 14, color: HexColor('#E02128')))
                    ])),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Input task name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Input task name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        controller.name = value;
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text('Description',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: HexColor('#808080'))),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Input description',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        controller.description = value;
                      },
                    )
                  ]),
            ),
          ]),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        height: 90,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                controller.isLoading ? Colors.lightGreen : Colors.blueAccent,
          ),
          child: controller.isLoading
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                  radius: 20.0,
                )
              : const Text(
                  'Submit',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
          onPressed: () {
            final name = controller.name;
            if (controller.formKey.currentState!.validate()) {
              controller.createTask(name: name);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    const HomeView(), // Gantilah 'HomePage' dengan nama kelas halaman yang sesuai
              ));
            }
          },
        ),
      ),
    );
  }
}
