import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:email/features/models/domain_post_ui_data_model.dart';
import 'package:email/features/models/messages_ui_data_model.dart';
import 'package:email/features/repos/domain_repo.dart';
import 'package:email/features/repos/message_inbox_repo.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

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
    emit(MessageFetchingLoadingState());
    try {
      List<MessageuiDataModel> posts = await MessageRepo.inbox(event.token);
      emit(MessageFetchingSuccessfullState(posts: posts));
    } catch (e) {
      emit(MessageFetchingErrorState());
    }
  }
}
