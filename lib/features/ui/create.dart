// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:email/features/ui/domain.dart';
import 'package:email/features/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:email/features/bloc/account_bloc.dart';
import 'package:email/features/models/clipPath.dart';

class create extends StatefulWidget {
  final String domain;
  const create({
    Key? key,
    required this.domain,
  }) : super(key: key);

  @override
  State<create> createState() => _createState();
}

class _createState extends State<create> {
  final AccountBloc accountBloc = AccountBloc();
  @override
  void initState() {
    super.initState();
    print('AccountBloc initialized');
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    bool _obsecure = true;
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Temp Mail")),
          elevation: 2,
          shadowColor: Colors.white,
        ),
        body: BlocListener<AccountBloc, AccountState>(
          bloc: accountBloc,
          // listenWhen: (previous, current) => current is AccountActionState,
          listener: (context, state) {
            if (state is PasswordVisibilityChangeState) {
              _obsecure = state.isPasswordVisible;
            }
            if (state is AccountCreateErrorState) {
              print(10);
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
            if (state is AccountCreateSuccessState) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Container(
                      child: AlertDialog(
                        title: Text("Alert"),
                        content:
                            Text("Congrats!!!You just create a new Account"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => login(),
                                  )); // Close the dialog
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  });
            }
          },
          child: Column(
            children: [
              custom(name: "Create New Account"),
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
                  Text(
                    widget.domain,
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: passwordController,
                  style: TextStyle(),
                  obscureText: _obsecure,
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          accountBloc.add(PasswordVisibilityChangeEvent());
                        },
                        icon: Icon(
                          _obsecure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                      )),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    String email = emailController.text + widget.domain;
                    String password = passwordController.text;
                    emailController.clear();
                    passwordController.clear();
                    accountBloc.add(
                        CreateAccountEvent(email: email, password: password));
                  },
                  style: ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(Size(300, 50))),
                  child: Text("Create an account")),
            ],
          ),
        ));
  }
}
