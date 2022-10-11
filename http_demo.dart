import 'package:http/http.dart' as http;
import 'dart:convert';
void main(List<String> arguments) async {
  var todo = await getTodo(1);
  print(todo.id);
  print(todo.title);
  var todos = await getTodos();
  print(todos[1].title);
}
Future<Todo> getTodo(int id) async {
  var uri = "https://jsonplaceholder.typicode.com/todos/$id";
  var response = await http.get(Uri.parse(uri));
  Map map = jsonDecode(response.body);
  var todo = Todo.fromJson(map);
  return todo;
}
Future<List<Todo>> getTodos() async {
  var uri = "https://jsonplaceholder.typicode.com/todos";
  var response = await http.get(Uri.parse(uri));
  var body = jsonDecode(response.body);
  var todos = body.map<Todo>((json) => Todo.fromJson(json)).toList();
  return todos;
}
class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;
  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });
  factory Todo.fromJson(Map map) {
    return Todo(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
      completed: map['completed'],
    );
  }
}