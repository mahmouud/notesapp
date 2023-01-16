import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notesapp/app/componant/crud.dart';
import 'package:notesapp/app/const/links.dart';
import 'package:notesapp/main.dart';
import '../componant/customtextfaild.dart';
import '../const/validator.dart';

class editnots extends StatefulWidget {
  final notes;

  const editnots({super.key, this.notes});

  @override
  State<editnots> createState() => _editnotsState();
}

TextEditingController titel = TextEditingController();
TextEditingController contact = TextEditingController();
GlobalKey<FormState> formstat = GlobalKey<FormState>();
File? myfile;

class _editnotsState extends State<editnots> with Crud {
  editnot() async {
    if (formstat.currentState!.validate()) {
      var respon;

      if (myfile == null) {
        respon = await postRequst(linkSupdatenote, {
          "not_titel": titel.text,
          "not_contact": contact.text,
          "not_id": widget.notes["not_id"].toString(),
          "imagename": widget.notes["not_image"].toString()
        });
        if (respon["status"] == "success") {
          Navigator.of(context).pushReplacementNamed("Home");
          // titel.text = "";
          //contact.text = "";
        } else {
          //
        }
      } else {
        respon = await postRequstWithfile(
            linkSupdatenote,
            {
              "not_titel": titel.text,
              "not_contact": contact.text,
              "not_id": widget.notes["not_id"].toString(),
              "imagename": widget.notes["not_image"].toString()
            },
            myfile!);
        if (respon["status"] == "success") {
          Navigator.of(context).pushReplacementNamed("Home");
          // titel.text = "";
          //contact.text = "";
        } else {
          //
        }
      }
    }
  }

  @override
  void initState() {
    titel.text = widget.notes["not_titel"];
    contact.text = widget.notes["not_contact"];
    super.initState();
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
                      await editnot();
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
    ;
  }
}
