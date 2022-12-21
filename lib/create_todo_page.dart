import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'todo_model.dart';

class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({Key? key}) : super(key: key);

  @override
  State<CreateTodoPage> createState() => _CreateTodoPageState();
}
String URL = 'https://jsonplaceholder.typicode.com/todos';

Future<ToDoModel?> createTodo(String userID, String id, String title, String completed) async {
  var url = Uri.parse(URL);
  var todoDetails = json.encode({
    'userId':userID,
    'id':id,
    'title': title,
    'completed': completed
  });
  var response = await http.post(url, body: todoDetails);

  if (response.statusCode == 201){
    print('\nSuccessfully Created ToDo.');
    print("UserID: $userID");
    print("ID: $id");
    print("Title: $title");
    print("Completed: $completed");
    print('\n$todoDetails');
    return ToDoModel.fromJson(convert.jsonDecode(response.body));
  } else {
    print('Failed to Create ToDo');
    throw Exception('Failed to Create ToDo');
  }
}

class _CreateTodoPageState extends State<CreateTodoPage> {

  final formKey = GlobalKey<FormState>();
  ToDoModel? todoModel;

  TextEditingController idController = TextEditingController();
  TextEditingController useridController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  String? completedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Details'),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            TextFormField(
                controller: idController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    icon: Icon(Icons.numbers),
                    hintText: 'User ID',
                    labelText: 'User ID'
                ),
                validator: (id) {
                  if(id!.isEmpty || !RegExp(r'[0-9]+$').hasMatch(id)) {
                    return 'Please enter your User ID.';
                  } else {
                    return null;
                  }
                }
            ),
            const SizedBox(height: 20),
            TextFormField(
                controller: useridController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    icon: Icon(Icons.account_circle),
                    hintText: 'ID',
                    labelText: 'ID'
                ),
                validator: (userid) {
                  if(userid!.isEmpty || !RegExp(r'[0-9]+$').hasMatch(userid)) {
                    return 'Please enter your ID.';
                  } else {
                    return null;
                  }
                }
            ),
            const SizedBox(height: 20),
            TextFormField(
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    icon: Icon(Icons.text_snippet),
                    hintText: 'Title',
                    labelText: 'Title'
                ),
                validator: (title) {
                  if(title!.isEmpty || !RegExp(r'[a-z A-Z,0-9]+$').hasMatch(title)) {
                    return 'Please enter your Title.';
                  } else {
                    return null;
                  }
                }
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              isExpanded: true,
              hint: const Text(
                'Select Status',
                style: TextStyle(
                    fontSize: 16
                ),
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'True',
                  child: Text('True'),
                ),
                DropdownMenuItem(
                  value: 'False',
                  child: Text('False'),
                ),
              ],
              validator: (status) {
                if(status == null) {
                  return 'Please select status.';
                } else {
                  return null;
                }
              },
              onChanged: (newValue) {
                setState(() {
                  completedValue = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  if(formKey.currentState!.validate()) {
                    ToDoModel? newDetails = await createTodo(
                        idController.text,
                        useridController.text,
                        titleController.text,
                        completedValue.toString()
                    );
                    setState(() {
                      todoModel = newDetails;
                    });
                  }
                  Navigator.pop(context,
                  );
                },
                child: const Text('SUBMIT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
