import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notesapp/app/componant/crud.dart';
import 'package:notesapp/app/const/links.dart';
import 'package:notesapp/app/const/validator.dart';
import 'package:notesapp/main.dart';
import '../componant/customtextfaild.dart';

class addnote extends StatefulWidget {
  const addnote({super.key});

  @override
  State<addnote> createState() => _addnoteState();
}

File? myfile;
TextEditingController titel = TextEditingController();
TextEditingController contact = TextEditingController();
GlobalKey<FormState> formstat = GlobalKey<FormState>();

class _addnoteState extends State<addnote> with Crud {
  addnot() async {
    if (myfile != null) {
      if (formstat.currentState!.validate()) {
        var respon = await postRequstWithfile(
            linkSaddnote,
            {
              "not_titel": titel.text,
              "not_contact": contact.text,
              "not_user": sharpref.getString("id")
            },
            myfile!);
        if (respon["status"] == "success") {
          Navigator.of(context).pushReplacementNamed("Home");
          titel.text = "";
          contact.text = "";
          myfile = null;
        } else {
          //
        }
      }
    } else {
      if (formstat.currentState!.validate()) {
        var respon = await postRequst(
          linkSaddnote,
          {
            "not_titel": titel.text,
            "not_contact": contact.text,
            "not_user": sharpref.getString("id")
          },
        );
        if (respon["status"] == "success") {
          Navigator.of(context).pushReplacementNamed("Home");
          titel.text = "";
          contact.text = "";
        } else {
          //
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Note")),
      body: Form(
        key: formstat,
        child: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  Custtextfaild(
                    hintee: "title note",
                    mycontroller: titel,
                    valing: (val) {
                      return ValidInput(val!, 14, 1);
                    },
                  ),
                  Custtextfaild(
                    hintee: "contact note",
                    mycontroller: contact,
                    valing: (val) {
                      return ValidInput(val!, 14, 1);
                    },
                  ),
                  MaterialButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                            child: Column(
                          children: [
                            MaterialButton(
                                onPressed: () async {
                                  XFile? xfile = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  myfile = File(xfile!.path);
                                  Navigator.of(context).pop();
                                },
                                child: Text(" select from camra")),
                            MaterialButton(
                                onPressed: () async {
                                  XFile? xfile = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  myfile = File(xfile!.path);
                                  Navigator.of(context).pop();
                                },
                                child: Text(" select from gulary"))
                          ],
                        )),
                      );
                    },
                    child: Text("Add image"),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      await addnot();
                      //  Navigator.of(context).pushReplacementNamed("Home");
                      //popAndPushNamed("Home");
                    },
                    child: Text("Add Note"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
