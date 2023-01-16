import 'package:flutter/material.dart';
import 'package:notesapp/app/const/links.dart';
import 'package:notesapp/app/model/notemodel.dart';

class CurdNots extends StatelessWidget {
  final void Function()? onPressedsedit;
  final void Function()? onPressedsdelet;

  final NoteModel noteModel;
  const CurdNots(
      {super.key,
      onpressed,
      required this.onPressedsedit,
      required this.onPressedsdelet,
      required this.noteModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: noteModel.notImage == null
                  ? Image.asset(
                      "images/logo.png",
                      width: 100,
                      height: 100,
                    )
                  : Image.network(
                      "$linkfile/${noteModel.notImage}",
                      width: 100,
                      height: 100,
                    )),
          Expanded(
            flex: 2,
            child: ListTile(
              title: Text("${noteModel.notTitel}"),
              subtitle: Text("${noteModel.notContact}"),
            ),
          ),
          Column(
            children: [
              IconButton(onPressed: onPressedsedit, icon: Icon(Icons.edit)),
              IconButton(onPressed: onPressedsdelet, icon: Icon(Icons.delete)),
              // MaterialButton(
              //   onPressed: () {},
              //   child: Text("delet"),
              // )
            ],
          ),
        ],
      ),
    );
  }
}
