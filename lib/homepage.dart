import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/todomodels.dart';

class homepage extends StatelessWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allTodos = Provider.of<TodoModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Todo App")),
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                allTodos.removeTodo();
              },
              icon: Icon(Icons.delete),
              label: Text("clear"))
        ],
      ),
      body: allTodos.items.length == 0
          ? Container(
              child: Center(
                  child: Text(
                "not found Todo\n clk + to add",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              )),
            )
          : ListView.builder(
              itemCount: allTodos.items.length,
              itemBuilder: (ctx, i) {
                return ListTile(
                  leading: allTodos.items[i].isimportant
                      ? GestureDetector(
                          onTap: () {
                            allTodos.Changeisimportant(i);
                          },
                          child: Icon(Icons.favorite),
                        )
                      : GestureDetector(
                          onTap: (() {
                            allTodos.Changeisimportant(i);
                          }),
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(Icons.favorite_outline_rounded),
                          ),
                        ),
                  title: Text(allTodos.items[i].title),
                  subtitle: Text(allTodos.items[i].description),
                  trailing: SizedBox(
                    height: 50,
                    width: 100,
                    child: Row(children: [
                      Flexible(
                          child: IconButton(
                        onPressed: () {},
                        color: Colors.brown,
                        icon: Icon(Icons.edit),
                      )),
                      Flexible(
                          child: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Do you want to delete?"),
                                  actions: [
                                    //ElevatedButton
                                    ElevatedButton(
                                        onPressed: () {
                                          allTodos.deleteTodo(i);
                                          Navigator.pop(context);
                                        },
                                        child: Text("Confirm delete ?")),

                                    //Outline button
                                    OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancel"))
                                  ],
                                );
                              });
                        },
                        icon: Icon(Icons.delete),
                      ))
                    ]),
                  ),
                );
              }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showAlertDialog(context);
        },
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  TextEditingController ctitle = TextEditingController();
  TextEditingController cDesc = TextEditingController();
  final allTodos = Provider.of<TodoModel>(context, listen: false);

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Add Todo "),
    content: Column(children: [
      TextField(
        controller: ctitle,
        decoration: InputDecoration(label: Text("Title")),
      ),
      TextField(
        controller: cDesc,
        decoration: InputDecoration(label: Text("description")),
      )
    ]),
    actions: [
      ElevatedButton(
          onPressed: () {
            var rng = Random();
            allTodos.addTodo(Todo(
                id: rng.nextInt(10000),
                title: ctitle.text,
                description: cDesc.text,
                isimportant: true));
            Navigator.pop(context);
          },
          child: Text("Save")),
      OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"))
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}