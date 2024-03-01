// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {}

class InitialFetchEvent extends PostsEvent {}

class MessageCheckEvent extends PostsEvent {
  String token;
  MessageCheckEvent({
    required this.token,
  });
}
