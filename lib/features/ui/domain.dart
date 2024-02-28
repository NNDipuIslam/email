import 'package:email/features/bloc/posts_bloc.dart';
import 'package:email/features/models/clipPath.dart';
import 'package:flutter/material.dart';

class domain extends StatefulWidget {
  const domain({super.key});

  @override
  State<domain> createState() => _domainState();
}

class _domainState extends State<domain> {
  final PostsBloc postsBloc = PostsBloc();
  @override
  void initState() {
    postsBloc.add(InitialFetchEvent());
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
      body: Column(
        children: [
          ClipPath(
            clipper: mycustomclipper(),
            child: Container(
              height: 150,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
