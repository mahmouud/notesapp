import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapp/app/componant/crud.dart';
import 'package:notesapp/app/componant/curdnots.dart';
import 'package:notesapp/app/const/links.dart';
import 'package:notesapp/app/model/notemodel.dart';
import 'package:notesapp/app/nots/addnots.dart';
import 'package:notesapp/app/nots/editnote.dart';
import 'package:notesapp/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {
  var respon;

  var xyz;
  Future<void> getnot() async {
    respon =
        await postRequst(linkSviewnote, {"not_user": sharpref.getString("id")});
    setState(() {});
    return respon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home "),
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
            ),
            onPressed: () {
              sharpref.clear();
              Navigator.popAndPushNamed(context, "Login");
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          //CurdNots(nottitel: "title", notcontact: "contant", onPresseds: () {})

          FutureBuilder(
              future: getnot(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  // if (snapshot.data['status'] == ['faild']) {
                  //   return Text("no have data");
                  // }
                  if (snapshot.data['status'] == 'success') {
                    return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return CurdNots(
                          //Delete Notes
                          onPressedsdelet: () async {
                            var resopnss = await postRequst(linkSdeletnote, {
                              "not_id":
                                  snapshot.data['data'][i]["not_id"].toString(),
                              "imagename": snapshot.data['data'][i]["not_image"]
                            });
                          },
                          noteModel:
                              NoteModel.fromJson(snapshot.data['data'][i]),
                          //Edit Notes go page edit
                          onPressedsedit: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    editnots(notes: snapshot.data['data'][i]),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }

//                    return Text("no have data${sharpref.getString("id")}");
                  return Row(
                    children: [
                      CircularProgressIndicator(),
                      Text("No Have data")
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text("${sharpref.getString("id")}---------"),
                  );
                }
                return Center(
                    child: Text("${sharpref.getString("key")}dsfsdfsdf"));
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(onPressed: () {
        Navigator.of(context).pushNamed("addnote");

        // addnote();
      }),
    );
  }
}
