part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

abstract class PostsActionState extends PostsState {}

class PostFetchingLoadingState extends PostsState {}

class PostFetchingErrorState extends PostsState {}

class NewPageNavigationState extends PostsState {
  final Widget destinationPage;

  NewPageNavigationState(this.destinationPage);
}

class PostFetchingSuccessfullState extends PostsState {
  final List<PostsUiDataModel> posts;

  PostFetchingSuccessfullState({required this.posts});
}
