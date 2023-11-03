import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ozora/module/edit_task/view/edit_task_view.dart';

class DetailTaskView extends StatelessWidget {
  final String taskId;
  final String taskName;
  final String description;

  DetailTaskView(
      {required this.taskId,
      required this.taskName,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Detail'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTaskView(
                        taskId: taskId,
                        taskName: taskName,
                        description: description ?? ''),
                  ),
                );
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('task').doc(taskId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              final taskData = snapshot.data!;
              final taskName = taskData['name'];
              final taskDescription = taskData['description'] ?? '';

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Task Name',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24)),
                    Text(
                      '$taskName',
                      style: TextStyle(fontSize: 20),
                    ),
                    Divider(),
                    SizedBox(height: 12),
                    const Text('Description',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24)),
                    Text(
                      '$taskDescription',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text('Task not found.'));
            }
          }
        },
      ),
    );
  }
}
