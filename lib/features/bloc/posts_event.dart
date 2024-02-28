part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {}

class InitialFetchEvent extends PostsEvent {}

class CreateAccountEvent extends PostsEvent {}
