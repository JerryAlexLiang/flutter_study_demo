import 'package:flutter/material.dart';

class KnowledgeSystemPage extends StatefulWidget {
  @override
  _KnowledgeSystemPageState createState() => _KnowledgeSystemPageState();
}

class _KnowledgeSystemPageState extends State<KnowledgeSystemPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Text("知识体系"),
          ],
        ),
      ),
    );
  }
}
