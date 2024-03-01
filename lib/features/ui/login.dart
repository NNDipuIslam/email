import 'package:email/features/bloc/account_bloc.dart';
import 'package:email/features/bloc/posts_bloc.dart';
import 'package:email/features/models/clipPath.dart';
import 'package:email/features/ui/dashboard.dart';
import 'package:email/features/ui/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AccountBloc accountBloc = AccountBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Temp Mail")),
        elevation: 2,
        shadowColor: Colors.white,
      ),
      body: BlocListener<AccountBloc, AccountState>(
          bloc: accountBloc,
          listener: (context, state) {
            if (state is AccountCheckSuccessState) {
              print(state.token);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => dashboard(
                            token: state.token,
                          )));
            }
            if (state is AccountCheckErrorState) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Container(
                      child: AlertDialog(
                        title: Text("Alert"),
                        content: Text("Sorry!!Somwthing is wrong"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  });
            }
          },
          child: Column(children: [
            custom(name: "Login"),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: 200,
                  child: TextField(
                    controller: emailController,
                    style: TextStyle(),
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: "username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: passwordController,
                style: TextStyle(),
                // obscureText: _obsecure,
                decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  /*suffixIcon: IconButton(
                    onPressed: () {
                      //   accountBloc.add(PasswordVisibilityChangeEvent());
                    },
                    icon: Icon(
                        // _obsecure ? Icons.visibility_off : Icons.visibility,
                        // color: Colors.grey,
                        )
                  )*/
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  String email = emailController.text + "@yogirt.com";
                  String password = passwordController.text;
                  emailController.clear();
                  passwordController.clear();
                  accountBloc
                      .add(CheckAccountEvent(email: email, password: password));
                },
                style: ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(300, 50))),
                child: Text("Log in")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => domain()));
                    },
                    child: Text(
                      "sign up",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            )
          ])),
    );
  }
}
