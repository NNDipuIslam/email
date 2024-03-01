import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:email/features/models/domain_post_ui_data_model.dart';
import 'package:email/features/models/messages_ui_data_model.dart';
import 'package:email/features/repos/check_account_repo.dart';
import 'package:email/features/repos/createAccount_repo.dart';
import 'package:email/features/repos/domain_repo.dart';
import 'package:email/features/repos/message_inbox_repo.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<InitialFetchEvent>(_postsinitialfetchevent);
    on<MessageCheckEvent>(_messageCheckEvent);
  }

  void _postsinitialfetchevent(
      InitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostFetchingLoadingState());
    try {
      List<PostsUiDataModel> posts = await DomainRepo.fetchPosts();
      emit(PostFetchingSuccessfullState(posts: posts));
    } catch (e) {
      emit(PostFetchingErrorState());
    }
  }

  FutureOr<void> _messageCheckEvent(
      MessageCheckEvent event, Emitter<PostsState> emit) async {
    print(10);
    emit(MessageFetchingLoadingState());
    print(10);
    try {
      //MessageuiDataModel result = await MessageRepo.inbox();
      List<MessageuiDataModel> posts = await MessageRepo.inbox(event.token);
      print(posts[0].from.address);
      emit(MessageFetchingSuccessfullState(posts: posts));
    } catch (e) {
      emit(MessageFetchingErrorState());
    }
  }
}
