import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

savepref() async {
  SharedPreferences shappp = await SharedPreferences.getInstance();
  shappp.setString("name", "55");
  print("Secsess");
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test')),
      body: Container(
        child: Column(
          children: [
            Text("data"),
            MaterialButton(
              onPressed: () async {
                await savepref();
              },
              child: Text("Run save prf"),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, "testing");
              },
              child: Text("go to page"),
            )
          ],
        ),
      ),
    );
  }
}
