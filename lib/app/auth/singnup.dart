import 'package:flutter/material.dart';
import 'package:notesapp/app/componant/crud.dart';
import 'package:notesapp/app/componant/customtextfaild.dart';
import 'package:notesapp/app/const/links.dart';
import 'package:notesapp/app/const/validator.dart';

class SignUP extends StatefulWidget {
  const SignUP({super.key});

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  GlobalKey<FormState> formstat = GlobalKey();
  TextEditingController contEmail = TextEditingController();
  TextEditingController contPass = TextEditingController();
  TextEditingController contUserName = TextEditingController();
  Crud _crud = Crud();
  bool isloading = false;

  signup() async {
    if (formstat.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var respon = await _crud.postRequst(linkSignup, {
        "username": contUserName.text,
        "email": contEmail.text,
        "userpass": contPass.text
      });
      isloading = false;
      if (respon["status"] == "success") {
        Navigator.of(context).pushNamed("Home");
      } else {
        print("object");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note App"),
      ),
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: ListView(
                children: [
                  Form(
                    key: formstat,
                    child: Column(children: [
                      Image.asset(
                        "images/logo.png",
                        width: 200,
                        height: 200,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Custtextfaild(
                        valing: (val) {
                          return ValidInput(val!, 14, 1);
                        },
                        hintee: "User Name",
                        mycontroller: contUserName,
                      ),
                      Custtextfaild(
                        valing: (val) {
                          return ValidInput(val!, 14, 1);
                        },
                        hintee: "Email",
                        mycontroller: contEmail,
                      ),
                      Custtextfaild(
                        valing: (val) {
                          return ValidInput(val!, 14, 1);
                        },
                        hintee: "Password",
                        mycontroller: contPass,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.of(context).popAndPushNamed("Login");
                              //("/");
                            },
                            // padding: EdgeInsets.symmetric(horizontal: 70, vertical: 70),
                            color: const Color.fromARGB(255, 54, 134, 199),
                            child: const Text("Login",
                                style: TextStyle(fontSize: 25)),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          MaterialButton(
                            onPressed: () async {
                              await signup();
                            },
                            // padding: EdgeInsets.symmetric(horizontal: 70, vertical: 70),
                            color: const Color.fromARGB(255, 54, 134, 199),
                            child: const Text("Register",
                                style: TextStyle(fontSize: 25)),
                          )
                        ],
                      ),
                    ]),
                  ),
                ],
              ),
            ),
    );
  }
}
