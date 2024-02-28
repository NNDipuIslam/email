import 'package:email/features/bloc/posts_bloc.dart';
import 'package:email/features/models/clipPath.dart';
import 'package:email/features/ui/create.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        body: BlocConsumer<PostsBloc, PostsState>(
            bloc: postsBloc,
            listenWhen: (previous, current) => current is PostsActionState,
            buildWhen: (previous, current) => current is! PostsActionState,
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case PostFetchingLoadingState:
                  return Scaffold(
                      body: Center(
                    child: CircularProgressIndicator(),
                  ));
                case PostFetchingSuccessfullState:
                  final successState = state as PostFetchingSuccessfullState;
                  return Container(
                    child: ListView.builder(
                      itemCount: successState.posts.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(children: [
                            custom(name: "Available Domains"),
                            TextButton(
                                onPressed: () {
                                  postsBloc.add(CreateAccountEvent());
                                },
                                child: Text("tap to create account or login")),
                            Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 226, 224, 224),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.email),
                                  Text(successState.posts[index].domain),
                                ],
                              ),
                            )
                          ]),
                        );
                      },
                    ),
                  );
                case PostFetchingErrorState:
                  return Scaffold(
                    body: Center(
                        child: Text(
                      "Error Occured",
                      style: TextStyle(fontSize: 20),
                    )),
                  );
                case AccountCreateSuccessState:
                  return Scaffold(
                    body: SnackBar(
                      content: Text('Sorry! Account is unable to create'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                case AccountCreateErrorState:
                  return Scaffold(
                    body: SnackBar(
                      content: Text('Sorry! Account is unable to create'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                default:
                  return Text("sorry");
              }
            }));
  }
}
