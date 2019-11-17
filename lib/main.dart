import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Center(child: PageInput()),
      ),
    );
  }
}

class PageInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Row(mainAxisSize: MainAxisSize.max, children: [
      Container(
        width: 200,
        height: 50,
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Location'),
        ),
      ),
      Container(
        width: 200,
        height: 50,
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Venue'),
        ),
      ),
    ]));
  }
}
