import 'package:uas/ui/berandaadmin.dart';
import 'package:uas/ui/inputpenjualan.dart';
import 'package:uas/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas/ui/home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class Berandauser extends StatefulWidget {
  @override
  _BerandauserState createState() => _BerandauserState();
}

class _BerandauserState extends State<Berandauser> {
  int count = 0;
  List penjualanList;
  String id, nama, email, photo;
  int level = 2;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      level = preferences.getInt("level");
      id = preferences.getString("id");
      nama = preferences.getString("nama");
      email = preferences.getString("email");
      photo = preferences.getString("photo");
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("level", 2);
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => Login()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  Future<List> getData() async {
    final response =
        await http.get('http://192.168.43.173/apiflutter/api/penjualan');
    return json.decode(response.body);
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.yellow,
          elevation: 2.0,
          child: ListTile(
              title: Text(
                penjualanList[index]['nama'],
                style: textStyle,
              ),
              subtitle: Row(
                children: <Widget>[
                  Text(penjualanList[index]['tanggal'].toString().toString()),
                  Text(
                    " | Rp. " + penjualanList[index]['harga'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " | " + penjualanList[index]['jumlah'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "  " + penjualanList[index]['jenis_jamtangan'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              trailing: GestureDetector(
                child: Icon(Icons.delete),
                onTap: () => confirm(
                    penjualanList[index]['id'], penjualanList[index]['nama']),
              ),
              onTap: () =>
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (BuildContext context) => new InputPenjualan(
                            list: penjualanList[index],
                            index: index,
                          )))),
        );
      },
    );
  }

  Future<http.Response> deletePenjualan(id) async {
    final http.Response response = await http
        .delete('http://192.168.43.173/apiflutter/api/penjualan/delete/$id');
    return response;
  }

  void confirm(id, nama) {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Anda yakin ingin menghapus penjualan '$nama'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            "OK Hapus!",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.red,
          onPressed: () {
            deletePenjualan(id);
            Navigator.of(context, rootNavigator: true).pop();
            initState();
          },
        ),
        new RaisedButton(
          child: new Text("Batal", style: new TextStyle(color: Colors.black)),
          color: Colors.blue,
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      ],
    );
    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    switch (level) {
      case 1:
        return Berandaadmin();
        break;
      case 2:
        return Scaffold(
          appBar: new AppBar(
            title: new Text("Admin"),
          ),
          drawer: new Drawer(
            child: new ListView(
              children: <Widget>[
                new ListTile(
                  title: new Text('logout'),
                  trailing: new Icon(Icons.settings),
                  onTap: () {
                    signOut();
                  },
                ),
              ],
            ),
          ),
          body: createListView(),
          //tombol add
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.keyboard),
              tooltip: 'Input Penjualan',
              onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new InputPenjualan(
                        list: null,
                        index: null,
                      )))),
        );
        break;
      default:
        return Login();
    }
  }
}
