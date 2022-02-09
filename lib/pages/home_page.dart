import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todoapp/models/task_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            _showAddTaskBottomSheet(context);
          },
          child: const Text(
            'Bugün Yapılacaklar',
            style: TextStyle(color: Colors.black),
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddTaskBottomSheet(context);
            },
          )
        ],
      ),
    );
  }

  void _showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          width: MediaQuery.of(context).size.width,
          child: ListTile(
              title: TextField(
            style: const TextStyle(fontSize: 24),
            decoration: const InputDecoration(
                hintText: "Yapılacak işinizi giriniz",
                border: InputBorder.none),
            onSubmitted: (value) {
              Navigator.of(context).pop();
              if (value.length > 3) {
                DatePicker.showTimePicker(context, showSecondsColumn: false,
                    onConfirm: (time) {
                  var task = Task.create(name: value, createdAt: time);
                });
              }
            },
          )),
        );
      },
    );
  }
}
