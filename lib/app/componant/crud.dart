import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';

String _basicAuth = 'Basic ' + base64Encode(utf8.encode('mahmoud:m1234'));

Map<String, String> myheaders = {'authorization': _basicAuth};

class Crud {
  getRequst(String url) async {
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        var responcebody = jsonDecode(res.body);
        return responcebody;
      } else {
        print("Error ${res.statusCode}");
      }
    } catch (e) {
      print("Error catch $e");
    }
  }

  postRequst(String url, Map data) async {
    try {
      var res = await http.post(Uri.parse(url), body: data, headers: myheaders);
      if (res.statusCode == 200) {
        var responcebody = jsonDecode(res.body);
        return responcebody;
      } else {
        print("Error ${res.statusCode}");
      }
    } catch (e) {
      print("Error catch $e");
    }
  }

  postRequstWithfile(String url, Map data, File file) async {
    var res = http.MultipartRequest("POST", Uri.parse(url));
    var lenght = await file.length();
    var stream = http.ByteStream(file.openRead());

    var mulipartgile = http.MultipartFile("file", stream, lenght,
        filename: basename(file.path));
    res.headers.addAll(myheaders);
    res.files.add(mulipartgile);
    data.forEach((key, value) {
      res.fields[key] = value;
    });
    var myrequest = await res.send();
    var responce = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      return jsonDecode(responce.body);
    } else {
      print("Error${myrequest.statusCode} ");
    }
  }
}
