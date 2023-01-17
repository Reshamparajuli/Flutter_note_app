import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Todotile extends StatelessWidget {
  final String taskname;
  final String taskdesc;
  Function(BuildContext)? edittask;

  Function(BuildContext)? deletefunction;
  Todotile(
      {Key? key,
      required this.taskname,
      required this.taskdesc,
      required this.deletefunction,
      required this.edittask})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Slidable(
          endActionPane: ActionPane(motion: StretchMotion(), children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(20),
              onPressed: deletefunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
            )
          ]),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.cyanAccent,
            ),
            child: ListTile(
              title: Text(taskname),
              subtitle: Text(taskdesc),
              trailing: PopupMenuButton(
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyanAccent),
                      borderRadius: BorderRadius.circular(20)),
                  onSelected: (value) {
                    if (value == "Edit") {
                      edittask!(context);
                    } else if (value == "Delete") {
                      deletefunction!(context);
                    }
                  },
                  itemBuilder: (context) {
                    return const [
                      PopupMenuItem(
                        value: "Edit",
                        child: Text("Edit"),
                      ),
                      PopupMenuItem(
                        value: "Delete",
                        child: Text("Delete"),
                      )
                    ];
                  }),
            ),
          ),
        ));
  }
}
