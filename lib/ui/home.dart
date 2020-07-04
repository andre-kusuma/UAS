import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uas/ui/inputpenjualan.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int count = 0;
  List penjualanList;

  @override
  void initState() {
    Future<List> penjualanListFuture = getData();
    penjualanListFuture.then((penjualanList) {
      setState(() {
        this.penjualanList = penjualanList;
        this.count = penjualanList.length;
      });
    });
    super.initState();
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
                    "  " + penjualanList[index]['jenis_kacamata'],
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
    return Scaffold(
      appBar: new AppBar(
        title: Text("Penjualan Jam Tangan"),
        leading: Icon(Icons.shop),
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
  }
}
