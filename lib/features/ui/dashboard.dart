// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:email/features/bloc/posts_bloc.dart';
import 'package:email/features/models/clipPath.dart';

class dashboard extends StatefulWidget {
  final String token;
  const dashboard({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  final PostsBloc postsBloc = PostsBloc();
  @override
  void initState() {
    postsBloc.add(MessageCheckEvent(token: widget.token));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int ans = 0;
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Temp Mail")),
          elevation: 2,
          shadowColor: Colors.white,
        ),
        body: BlocConsumer<PostsBloc, PostsState>(
            bloc: postsBloc,
            listenWhen: (previous, current) => current is PostsActionState,
            buildWhen: (previous, current) => current is! PostsActionState,
            listener: (context, state) {},
            builder: (context, state) {
              if (state is MessageFetchingLoadingState) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is MessageFetchingSuccessfullState) {
                final to = state.posts[0].to[0].address;
                return Column(children: [
                  custom(name: to),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.3,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "From",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(state.posts[index].from.name +
                                      "<" +
                                      state.posts[index].from.address +
                                      ">"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "To",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("<" + to + ">"),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Time",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(state.posts[index].createdAt.toString()),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Subject",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(state.posts[index].subject),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Details",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    state.posts[index].intro,
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            )
                          ]),
                        );
                      },
                    ),
                  ),
                ]);
              } else {
                return Text("Sorry");
              }
            }));
  }
}
