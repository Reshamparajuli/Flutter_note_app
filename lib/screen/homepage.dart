import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/Models/dbhelper.dart';
import 'package:todo_app/boxes/boxes.dart';
import 'package:todo_app/screen/add_task.dart';
import 'package:todo_app/widgets/todotile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const Addtask()))
              .whenComplete(() {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
      backgroundColor: Colors.white60,
      appBar: AppBar(
        title: const Text("Todo"),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<DbHelper>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<DbHelper>();
          if (data.isEmpty) {
            return const Center(
                child: Text(
              "No task found!!!",
              style: TextStyle(fontSize: 20),
            ));
          }
          return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                return Todotile(
                  taskname: data[index].title.toString(),
                  taskdesc: data[index].description.toString(),
                  edittask: (p0) {
                    editTask(
                      data[index],
                      data[index].title.toString(),
                      data[index].description.toString(),
                    );
                  },
                  deletefunction: (p0) {
                    deleteTask(data[index]);
                  },
                );
              });
        },
      ),
    ));
  }

  Future<void> editTask(DbHelper item, String title, String description) async {
    TextEditingController taskcontroller = TextEditingController();
    TextEditingController desccontroller = TextEditingController();

    taskcontroller.text = title.toString();
    desccontroller.text = description.toString();
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Text("Edit task"),
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: taskcontroller,
                      maxLength: 10,
                      decoration: const InputDecoration(
                          hintText: "Enter title",
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.cyan, width: 2))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: desccontroller,
                      maxLength: 500,
                      maxLines: 10,
                      decoration: const InputDecoration(
                          hintText: "Enter title",
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.cyan, width: 2))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          item.title = taskcontroller.text.toString();
                          item.description = desccontroller.text.toString();
                          item.save();
                          Navigator.pop(context);
                        },
                        child: const Text("Edit")),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  void deleteTask(DbHelper item) async {
    await item.delete();
  }
}
