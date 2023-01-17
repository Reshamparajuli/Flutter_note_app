import 'package:flutter/material.dart';
import 'package:todo_app/Models/dbhelper.dart';
import 'package:todo_app/boxes/boxes.dart';

import 'package:todo_app/screen/homepage.dart';

class Addtask extends StatefulWidget {
  const Addtask({
    Key? key,
  }) : super(key: key);

  @override
  State<Addtask> createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {
  final taskcontroller = TextEditingController();
  final desccontroller = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MyHomePage()));
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text(
          "Add task",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return "Title should be provided";
                    }
                  }),
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Description should be provided";
                    }
                  },
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
                      if (formkey.currentState!.validate()) {
                        final data = DbHelper(
                            description: desccontroller.text,
                            title: taskcontroller.text);
                        final box = Boxes.getData();
                        box.add(data);
                        data.save();

                        Navigator.of(context).pop();
                      }

                      // dbhelper.updateDatabase();
                    },
                    child: const Text("Add")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
