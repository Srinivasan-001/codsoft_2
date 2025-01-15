import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/database.dart';
import 'package:flutter_application_1/util/dailog_box.dart';
import 'package:flutter_application_1/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool value, int index) {
    setState(() {
      db.toDolist[index][1] = value;
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDolist.add([_controller.text, false]);
      _controller.clear();
    });
    db.updateDataBase();
    Navigator.of(context).pop();
  }

  void editTask(int index) {
    _controller.text = db.toDolist[index][0];
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () {
            setState(() {
              db.toDolist[index][0] = _controller.text;
              _controller.clear();
            });
            db.updateDataBase();
            Navigator.of(context).pop();
          },
          onCancel: () {
            _controller.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDolist.removeAt(index);
    });
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () {
            _controller.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDolist.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              deleteTask(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Task deleted!")),
              );
            },
            child: ToDoTile(
              taskName: db.toDolist[index][0],
              taskCompleted: db.toDolist[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              onEdit: () => editTask(index),
            ),
          );
        },
      ),
    );
  }
}
