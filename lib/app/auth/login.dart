import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/app/componant/crud.dart';
import 'package:notesapp/app/componant/customtextfaild.dart';
import 'package:notesapp/app/const/links.dart';
import 'package:notesapp/app/const/validator.dart';
import 'package:notesapp/app/home.dart';
import 'package:notesapp/main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formstat = GlobalKey();
  TextEditingController contEmail = TextEditingController();
  TextEditingController contPass = TextEditingController();
  Crud _curd = Crud();
  var xyz;
  Future<void> singin() async {
    if (formstat.currentState!.validate()) {
      var resopns = await _curd.postRequst(linkSignin, {
        "email": contEmail.text,
        "userpass": contPass.text,
      });
      if (resopns["status"] == "success") {
        setState(() {
          sharpref.setString("key", contEmail.text);
          sharpref.setString("id", resopns["data"]["id"].toString());
          sharpref.setString("username", resopns["data"]["user_name"]);
          sharpref.setString("email", resopns["data"]["user_email"]);
          xyz = sharpref.setString(
              "email", resopns["data"]["user_name"].toString());
          Navigator.of(context).popAndPushNamed("Home");
          print("============================$xyz");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("sdfdsf")),
      body: Center(
        child: ListView(
          children: [
            Form(
              key: formstat,
              child: Column(children: [
                Image.asset("images/logo.png", width: 200, height: 200),
                const SizedBox(height: 40),
                Custtextfaild(
                    valing: (val) {
                      return ValidInput(val!, 14, 1);
                    },
                    hintee: "Email",
                    mycontroller: contEmail),
                Custtextfaild(
                    valing: (val) {
                      return ValidInput(val!, 10, 1);
                    },
                    hintee: "Password",
                    mycontroller: contPass),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        singin();
                        print(xyz.toString());
                      },
                      // padding: EdgeInsets.symmetric(horizontal: 70, vertical: 70),
                      color: Colors.blue,
                      child: Text("Login", style: TextStyle(fontSize: 25)),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("signup");
                      },
                      // padding: EdgeInsets.symmetric(horizontal: 70, vertical: 70),
                      color: Colors.blue,
                      child: Text("SignUp", style: TextStyle(fontSize: 25)),
                    ),
                  ],
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
