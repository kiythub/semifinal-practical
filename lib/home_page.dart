import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'create_todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

String URL = 'https://jsonplaceholder.typicode.com/todos';

class _HomePageState extends State<HomePage> {

  List todos = <dynamic>[];

  @override
  void initState() {
    super.initState();
    getTodo();
  }

  getTodo() async {
    var url = Uri.parse(URL);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        todos = convert.jsonDecode(response.body) as List<dynamic>;
      });
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SEMI FINAL PRACTICAL API'),
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return Card(
                elevation: 10,
                shadowColor: Colors.blueAccent,
                child: ListTile(
                  leading: const Icon(Icons.text_snippet_rounded),
                  title: Text(todos[index]['title']),
                )
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var getDetails = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateTodoPage()
              )
          );
          setState(() {
            todos.add(getDetails);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}



