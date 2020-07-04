import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:http/http.dart' as http;
import './home.dart';
import 'dart:async';

class InputPenjualan extends StatelessWidget {
  final list;
  final index;
  InputPenjualan({this.list, this.index});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: index == null ? "Transaksi Baru" : "Update Transaksi",
      home: Scaffold(
        appBar: AppBar(
          title:
              index == null ? Text("Transaksi Baru") : Text("Update Transaksi"),
          leading: Icon(Icons.shop),
        ),
        body: MyCustomForm(
          list: list,
          index: index,
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  final list;
  final index;
  MyCustomForm({this.list, this.index});
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController jenis_jamtanganController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  final format = DateFormat('yyyy-MM-dd');
  Future<http.Response> adddata(index) async {
    if (index == null) {
      final http.Response response = await http
          .post("http://192.168.43.173/apiflutter/api/penjualan/save", body: {
        'nama': nameController.text,
        'jenis_jamtangan': jenis_jamtanganController.text,
        'jumlah': jumlahController.text,
        'harga': hargaController.text,
        'tanggal': tanggalController.text,
      });
      return response;
    } else {
      final http.Response response = await http.post(
          "http://192.168.43.173/apiflutter/api/penjualan/save_update",
          body: {
            'id': widget.list['id'],
            'nama': nameController.text,
            'jenis_jamtangan': jenis_jamtanganController.text,
            'jumlah': jumlahController.text,
            'harga': hargaController.text,
            'tanggal': tanggalController.text,
          });
      return response;
    }
  }

  @override
  void initState() {
    if (widget.index == null) {
      nameController = TextEditingController();
      jenis_jamtanganController = TextEditingController();
      jumlahController = TextEditingController();
      hargaController = TextEditingController();
      tanggalController = TextEditingController();
    } else {
      nameController = TextEditingController(text: widget.list['nama']);
      jenis_jamtanganController =
          TextEditingController(text: widget.list['jenis_jamtangan']);
      jumlahController = TextEditingController(text: widget.list['jumlah']);
      hargaController = TextEditingController(text: widget.list['harga']);
      tanggalController = TextEditingController(text: widget.list['tanggal']);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Mohon isi Nama Lengkap';
                  }
                  return null;
                },
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Nama",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0)),
                )),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              controller: jenis_jamtanganController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Jenis Jam Tangan",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0)),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Mohon isi jenis jam tangan yang dipilih';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              controller: jumlahController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Jumlah",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0)),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Mohon isi dengan angka';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              controller: hargaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Harga",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0)),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Mohon isi total harga';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                DateTimeField(
                  controller: tanggalController,
                  format: format,
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2045));
                  },
                  decoration: InputDecoration(
                    labelText: "Tanggal",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0)),
                  ),
                  validator: (DateTime dateTime) {
                    if (dateTime == null) {
                      return "Mohon diisi tanggal";
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      "Simpan",
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        adddata(widget.index);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new Home()));
                      }
                    },
                  ),
                ),
                Container(
                  width: 5.0,
                ),
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      "Batal",
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => new Home()));
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
