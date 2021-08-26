
import 'package:eztour_traveller/datasource/remote/announcement_service.dart';
import 'package:eztour_traveller/schema/announcement/todo.dart';
import 'package:eztour_traveller/schema/announcement/todo_list_request.dart';
import 'package:eztour_traveller/schema/announcement/todo_list_response.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({Key? key}) : super(key: key);

  @override
  _AnnouncementScreenState createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {

  final service = AnnouncementService(Dio(BaseOptions(contentType: "application/json")));

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

  void _getTodoList() async {
    try {
      TodoListResponse response = await service.getTodoList(TodoListRequest());

      setState(() {
        _todos = response.todos;
      });
    } catch(e) {
      print('Error: $e');
    }
  }


  void _toggleTodo(int index){
    setState(() {
      _todos[index].done = !_todos[index].done;
    });
  }

  Widget _buildCheckIcon(bool done){
    return done ? Icon(Icons.check_circle, color: Colors.green, size: 32)
        : Icon(Icons.radio_button_unchecked, color: Colors.grey, size: 32);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Announcement",
            style: TextStyle(fontSize: 25.0),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: _todos.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child:  ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  title: Text(_todos[index].message, style: TextStyle(fontSize: 20)),
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
