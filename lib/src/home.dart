// ignore_for_file: prefer_const_constructors, deprecated_member_use, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Inicial'),
      ),
      body: Center(
          child: Container(
              child: Column(
                children: [
                  Text(
                    'Bem Vindo Ao App',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(height: 20),
                  RaisedButton(
                    child: Text('Ir para teste'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/test');
                    },
                  ),
                ],
      ))),
    );
  }
}
