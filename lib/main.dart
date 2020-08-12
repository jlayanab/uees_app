import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

void main() => runApp(MyApp(persona: fetchPost()));

Future<Persona> fetchPost() async {
  final response =
      await http.get("http://jlayanab.ddns.net:3000/api/v1/users/1");
  if (response.statusCode == 200) {
    return Persona.fromJson(json.decode(response.body));
  } else {
    throw Exception("Falls");
  }
}

Persona personaFromJson(String str) => Persona.fromJson(json.decode(str));

String personaToJson(Persona data) => json.encode(data.toJson());

class Persona {
  Persona({
    this.user,
  });

  User user;

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class User {
  User({
    this.id,
    this.username,
  });

  int id;
  String username;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
      };
}

class MyApp extends StatelessWidget {
  final Future<Persona> persona;
  MyApp({Key key, this.persona}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Registro UEES 2020",
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Registro UEES 2020"),
          //centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _add,
            ),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: _add,
            ),
          ],

          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  color: Colors.orange,
                  height: 100,
                  width: 100,
                ),
                FutureBuilder<Persona>(
                    future: persona,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data.user.username,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightGreen),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    }),
                Row(
                  children: <Widget>[
                    Expanded(child: Text("Activar Sonido")),
                    Switch(
                      value: true,
                      onChanged: (value) {},
                    )
                  ],
                ),
              ]),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_circle),
          onPressed: () {},
        ),
        //drawer: Drawer(),
        //endDrawer: Drawer(),
        //backgroundColor: Colors.greenAccent,
      ),
    );
  }

  void _add() {
    print("Hola");
  }
}
