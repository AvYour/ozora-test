import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ozora/module/create_task/view/create_task_view.dart';
import 'package:ozora/module/detail_task/view/detail_task_view.dart';
import 'package:ozora/module/home/controller/home_controller.dart';
import 'package:ozora/core.dart';
import 'package:flutter_scrolling_fab_animated/flutter_scrolling_fab_animated.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => HomeController();
  Widget build(context, HomeController controller) {
    controller.view = this;
    ScrollController scrollController = ScrollController();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('To-Do App',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.black)),
          centerTitle: true,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 1024) {
              return StreamBuilder(
                  stream: controller.db.collection('task').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Column(children: [
                          Container(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            width: double.maxFinite,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    HexColor('#164863'),
                                    HexColor('#427D9D'),
                                  ],
                                )),
                            child: Row(
                              children: [
                                GradientText(
                                  'Welcome ',
                                  style: TextStyle(
                                    fontSize: 38.0,
                                  ),
                                  colors: [
                                    HexColor("#9BBEC8"),
                                    HexColor('#DDF2FD')
                                  ],
                                ),
                                GradientText(
                                  controller.user + '!',
                                  style: TextStyle(
                                    fontSize: 38.0,
                                  ),
                                  colors: [Colors.white, HexColor('#DDF2FD')],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: snapshot.data?.docs.length,
                                  physics: const ScrollPhysics(),
                                  itemBuilder: (context, int index) {
                                    DocumentSnapshot documentSnapshot =
                                        snapshot.data.docs[index];
                                    final taskId = documentSnapshot.id;
                                    final taskName =
                                        documentSnapshot['name'] ?? '';
                                    final description =
                                        documentSnapshot['description'] ?? '';
                                    return InkWell(
                                        onTap: () async {
                                          controller.setPreferences(
                                              taskId, taskName, description);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailTaskView(
                                                      taskId: taskId,
                                                      taskName: taskName,
                                                      description: description),
                                            ),
                                          );
                                        },
                                        child: Dismissible(
                                            key: UniqueKey(),
                                            onDismissed: (detail) {},
                                            confirmDismiss: (direction) async {
                                              bool confirm = false;
                                              await showDialog<void>(
                                                context: context,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                        const Text('Confirm'),
                                                    content:
                                                        const SingleChildScrollView(
                                                      child: ListBody(
                                                        children: <Widget>[
                                                          Text(
                                                            'Are you sure you want to delete this item?',
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .blue),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          "No",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                        onPressed: () {
                                                          confirm = true;
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text("Yes",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              if (confirm) {
                                                await controller.db
                                                    .collection('task')
                                                    .doc(documentSnapshot.id)
                                                    .delete();
                                                return Future.value(true);
                                              }
                                              return Future.value(false);
                                            },
                                            child: Card(
                                              child: ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(taskName,
                                                      style: TextStyle(
                                                          fontSize: 24)),
                                                  subtitle: Text(description)),
                                            )));
                                  }))
                        ]),
                      );
                    }
                  });
            } else {
              return StreamBuilder(
                  stream: controller.db.collection('task').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Column(children: [
                          Container(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            width: double.maxFinite,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    HexColor('#164863'),
                                    HexColor('#427D9D'),
                                  ],
                                )),
                            child: Row(
                              children: [
                                GradientText(
                                  'Welcome ',
                                  style: TextStyle(
                                    fontSize: 38.0,
                                  ),
                                  colors: [
                                    HexColor("#9BBEC8"),
                                    HexColor('#DDF2FD')
                                  ],
                                ),
                                GradientText(
                                  controller.user + '!',
                                  style: TextStyle(
                                    fontSize: 38.0,
                                  ),
                                  colors: [Colors.white, HexColor('#DDF2FD')],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: snapshot.data?.docs.length,
                                  physics: const ScrollPhysics(),
                                  itemBuilder: (context, int index) {
                                    DocumentSnapshot documentSnapshot =
                                        snapshot.data.docs[index];
                                    final taskId = documentSnapshot.id;
                                    final taskName =
                                        documentSnapshot['name'] ?? '';
                                    final description =
                                        documentSnapshot['description'] ?? '';
                                    return InkWell(
                                        onTap: () async {
                                          controller.setPreferences(
                                              taskId, taskName, description);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailTaskView(
                                                      taskId: taskId,
                                                      taskName: taskName,
                                                      description:
                                                          description ?? ''),
                                            ),
                                          );
                                        },
                                        child: Dismissible(
                                            key: UniqueKey(),
                                            onDismissed: (detail) {},
                                            confirmDismiss: (direction) async {
                                              bool confirm = false;
                                              await showDialog<void>(
                                                context: context,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                        const Text('Confirm'),
                                                    content:
                                                        const SingleChildScrollView(
                                                      child: ListBody(
                                                        children: <Widget>[
                                                          Text(
                                                            'Are you sure you want to delete this item?',
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .blue),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          "No",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                        onPressed: () {
                                                          confirm = true;
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text("Yes",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              if (confirm) {
                                                await controller.db
                                                    .collection('task')
                                                    .doc(documentSnapshot.id)
                                                    .delete();
                                                return Future.value(true);
                                              }
                                              return Future.value(false);
                                            },
                                            child: Card(
                                              child: ListTile(
                                                  leading: Icon(
                                                      Icons.check_circle,
                                                      color: Colors.green),
                                                  title: Text(taskName,
                                                      style: TextStyle(
                                                          fontSize: 24)),
                                                  subtitle: Text(description)),
                                            )));
                                  }))
                        ]),
                      );
                    }
                  });
            }
          },
        ),
        floatingActionButton: ScrollingFabAnimated(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          text: const Text(
            'Add',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          onPress: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateTaskView()),
            );
          },
          scrollController: scrollController,
          animateIcon: true,
          inverted: false,
          radius: 10.0,
        ));
  }
}
