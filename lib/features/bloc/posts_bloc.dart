import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:email/features/models/domain_post_ui_data_model.dart';
import 'package:email/features/repos/createAccount_repo.dart';
import 'package:email/features/repos/domain_repo.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<InitialFetchEvent>(postsinitialfetchevent);
    on<CreateAccountEvent>(createAccountEvent);
  }

  void postsinitialfetchevent(
      InitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostFetchingLoadingState());
    try {
      List<PostsUiDataModel> posts = await DomainRepo.fetchPosts();
      emit(PostFetchingSuccessfullState(posts: posts));
    } catch (e) {
      emit(PostFetchingErrorState());
    }
  }

  void createAccountEvent(
      CreateAccountEvent event, Emitter<PostsState> emit) async {
    bool success = await CreateAccountRepo.create(
        "hdsfljhsdaflkjhsalkdjh@yogirt.com", "hi123");
    print(success);
    if (success == true) {
      emit(AccountCreateSuccessState());
    } else {
      emit(AccountCreateErrorState());
    }
  }
}
