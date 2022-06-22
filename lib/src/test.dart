import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({required this.userId, required this.id,required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body']
    );
  }

}

Future<List<Post>> pegarPosts() async{

  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  if(response.statusCode == 200){
    return parsePosts(response.body);
  }else{
    throw Exception('Falhou na requisição do Post');
  }

}

List<Post>parsePosts(String responseBody){
   var parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
   return parsed.map<Post>((json)=> Post.fromJson(json)).toList();
} 

class PostsList extends StatelessWidget{

  final List<Post> posts;

  PostsList({required this.posts});

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index){
        return ListTile(
          leading: Icon(Icons.cake),
          title: Text(posts[index].title),
          subtitle: Text(posts[index].body),
        );
      },
    );
  }

}


class TestPage extends StatefulWidget {
  @override
  _TestPage createState() => _TestPage();
}

class _TestPage extends State<TestPage> {

  late Future<List<Post>> postagens;

  @override
  void initState(){
    super.initState();

    postagens = pegarPosts();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de Teste'),
      ),
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: postagens,
          builder: (context, snapshot){
              if(snapshot.hasData){
                return PostsList(
                  posts: snapshot.requireData
                );
              }
              return CircularProgressIndicator();
          },
        ),
      )
    );
  }
}
