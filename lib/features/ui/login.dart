import 'package:email/features/models/clipPath.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Temp Mail")),
        elevation: 2,
        shadowColor: Colors.white,
      ),
      body: Column(
        children: [
          ClipPath(
            clipper: mycustomclipper(),
            child: Container(
              height: 150,
              color: Colors.blue,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                filled: true,
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            style: TextStyle(),
            obscureText: true,
            decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                filled: true,
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(Size(300, 50))),
              child: Text("Log in")),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Do you have an account?"),
              TextButton(onPressed: () {}, child: Text("sign Up"))
            ],
          )
        ],
      ),
    );
  }
}
