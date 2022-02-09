import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todoapp/models/task_model.dart';
import 'package:todoapp/widgets/task_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Task> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = <Task>[];
  }

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
            icon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
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
      body: _tasks.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                var _task = _tasks[index];
                return Dismissible(
                  background: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.delete, color: Colors.grey),
                      SizedBox(width: 8),
                      Text('Bu görev silindi'),
                    ],
                  ),
                  key: Key(_task.id),
                  onDismissed: (direction) {
                    _tasks.removeAt(index);
                    setState(() {});
                  },
                  child: TaskItem(
                    task: _task,
                  ),
                );
              },
              itemCount: _tasks.length,
            )
          : const Center(
              child: Text('Henüz bir görev eklenmedi.'),
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
            autofocus: true,
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
                  _tasks.add(task);
                  setState(() {});
                });
              }
            },
          )),
        );
      },
    );
  }
}
