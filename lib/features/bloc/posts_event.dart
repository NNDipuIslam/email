part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {}

class InitialFetchEvent extends PostsEvent {}

class NavigateToPage extends PostsEvent {
  final Widget destinationPage;

  NavigateToPage(this.destinationPage);
}
