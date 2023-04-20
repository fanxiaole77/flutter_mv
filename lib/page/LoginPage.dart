import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mv/page/Indexpage.dart';
import 'package:flutter_mv/service/http_config.dart';
import 'package:flutter_mv/service/http_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username = TextEditingController();
  final password = TextEditingController();

  void _login() {
    final response = post(
        postLogin,
        data: {'username': username.text, 'password': password.text}
        );

    response.then((respomse) {
      var data = json.decode(respomse.toString());
      print("$data");
      if (data['code'] == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IndexPage()),
        );
        token = data['token'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              child: TextFormField(
                controller: username,
                decoration: InputDecoration(
                    labelText: '用户名',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.black12, width: 2))),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 250,
              child: TextFormField(
                controller: password,
                decoration: InputDecoration(
                    labelText: '密码',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.black12, width: 2))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 250,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  child: Text("登录")),
            )
          ],
        ),
      ),
    );
  }
}
