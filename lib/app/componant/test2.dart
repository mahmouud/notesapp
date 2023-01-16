import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class testing extends StatefulWidget {
  const testing({super.key});
  //
  @override
  State<testing> createState() => _testingState();
}

var sharing;
Future<void> getpref() async {
  SharedPreferences shappp = await SharedPreferences.getInstance();

  sharing = shappp.getString("name");
  print("Secsess");
}

class _testingState extends State<testing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("get shared")),
      body: Column(children: [
        Text("$sharing"),
        MaterialButton(
          onPressed: () async {
            await getpref();
            setState(() {});
          },
          child: Text("mahmoud"),
        )
      ]),
    );
  }
}
