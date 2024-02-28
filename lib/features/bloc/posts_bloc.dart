import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:email/features/models/domain_post_ui_data_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<InitialFetchEvent>(postsinitialfetchevent);
    on<NavigateToPage>(navigateToPage);
  }

  void postsinitialfetchevent(
      InitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostFetchingLoadingState());
    var client = http.Client();
    List<PostsUiDataModel> posts = [];
    try {
      var response =
          await client.get(Uri.parse('https://api.mail.tm/domains?page=1'));
      if (response.statusCode == 200) {
        String json =
            '{"@context":"/contexts/Domain","@id":"/domains","@type":"hydra:Collection","hydra:totalItems":1,"hydra:member":[{"@id":"/domains/65da256aad121469f753d84c","@type":"Domain","id":"65da256aad121469f753d84c","domain":"yogirt.com","isActive":true,"isPrivate":false,"createdAt":"2024-02-24T00:00:00+00:00","updatedAt":"2024-02-24T00:00:00+00:00"}]}';

        Map<String, dynamic> data = jsonDecode(response.body);

        int totalItems = data['hydra:totalItems'];
        List<dynamic> result = data['hydra:member'];
        for (int i = 0; i < totalItems; i++) {
          PostsUiDataModel post = PostsUiDataModel.fromJson(result[i]);
          posts.add(post);
        }

        emit(PostFetchingSuccessfullState(posts: posts));
      }
    } catch (e) {
      emit(PostFetchingErrorState());
    } finally {
      client.close(); // Close the HttpClient
    }
  }

  FutureOr<void> navigateToPage(
      NavigateToPage event, Emitter<PostsState> emit) {
    Stream<PostsState> mapEventToState(PostsEvent event) async* {
      if (event is NavigateToPage) {
        yield NewPageNavigationState(event.destinationPage);
      }
    }
  }
}
