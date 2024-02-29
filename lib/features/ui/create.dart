import 'package:email/features/bloc/account_bloc.dart';
import 'package:email/features/models/clipPath.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class create extends StatefulWidget {
  const create({super.key});

  @override
  State<create> createState() => _createState();
}

class _createState extends State<create> {
  final AccountBloc accountBloc = AccountBloc();
  @override
  void initState() {
    super.initState();
  }

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
          listenWhen: (previous, current) => current is AccountActionState,
          listener: (context, state) {
            if (state is AccountCreateErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Sorry! Account is unable to create'),
                duration: Duration(seconds: 2),
              ));
            }
            if (state is AccountCreateSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Hey! Account is create'),
                duration: Duration(seconds: 2),
              ));
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
                    "@yogirt.com",
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
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
              ),
              ElevatedButton(
                  onPressed: () {
                    accountBloc.add(CreateAccountEvent());
                  },
                  style: ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(Size(300, 50))),
                  child: Text("Create an account")),
            ],
          ),
        ));
  }
}
