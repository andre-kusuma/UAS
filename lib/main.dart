import 'package:uas/ui/berandaadmin.dart';
import 'package:uas/ui/berandauser.dart';
import 'package:uas/ui/home.dart';
import 'package:uas/ui/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
      title: 'Penjualan Jam Tangan',
      home: Berandauser(),
      routes: <String, WidgetBuilder>{
        '/Berandauser': (BuildContext context) => new Berandauser(),
        '/Berandaadmin': (BuildContext context) => new Berandaadmin(),
        '/login': (BuildContext context) => Login(),
        '/Penjualan': (BuildContext context) => new Home(),
      },
    ));
