
import 'package:eztour_traveller/datasource/remote/checklist_service.dart';
import 'package:eztour_traveller/schema/checklist/checklist_request.dart';
import 'package:eztour_traveller/schema/checklist/todo.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({Key? key}) : super(key: key);

  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {

  final service = ChecklistService(Dio(BaseOptions(contentType: "application/json")));

  List<Todo> _todos = [];

  // List<Todo> _todos = [
  //     Todo(id: 1, message: "Design", done: true),
  //     Todo(id: 2, message: "Code", done: false),
  //     Todo(id: 3, message: "Review", done: false),
  // ];

  @override
  void initState() {
    _getTodoList();

    super.initState();
  }

  Future _getTodoList() async {
    try {
      final response = await service.getChecklist(ChecklistRequest());

      setState(() {
        _todos = response.todos;
      });
    } catch(e) {
      debugPrint('Error: $e');
    }
  }


  void _toggleTodo(int index){
    setState(() {
      _todos[index].done = !_todos[index].done;
    });
  }

  Widget _buildCheckIcon(bool done){
    return done ? const Icon(Icons.check_circle, color: Colors.green, size: 32)
        : const Icon(Icons.radio_button_unchecked, color: Colors.grey, size: 32);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            "Checklist",
            style: TextStyle(fontSize: 25.0),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: _todos.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child:  ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  title: Text(_todos[index].message, style: const TextStyle(fontSize: 20)),
                  trailing: IconButton(
                    icon: _buildCheckIcon(_todos[index].done),
                    onPressed: () => _toggleTodo(index),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          )
        ],
      ),
    );
  }
}
