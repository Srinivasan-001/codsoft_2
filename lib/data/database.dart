import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDolist = [];

  //reference our bx
  final _myBox = Hive.box('mybox');
  //run this method if this 1st time ever opening this app
  void createInitialData() {
    toDolist = [
      ["tutorial", false],
      ["do walking", false],
    ];
  }

//load the data from the database
  void loadData() {
    toDolist = _myBox.get("TODOLIST");
  }

//update the databasae
  void updateDataBase() {
    _myBox.put("TODOLIST", toDolist);
  }
}
