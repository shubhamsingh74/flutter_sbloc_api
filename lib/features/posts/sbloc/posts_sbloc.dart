import 'dart:async';
import 'package:flutter_sbloc_api/features/posts/models/post_data_ui_model.dart';
import 'package:flutter_sbloc_api/features/posts/repo/post_repo.dart';
import 'package:flutter_sbloc_api/features/posts/sbloc/posts_events.dart';
import 'package:flutter_sbloc_api/simplified_bloc.dart';

final ApiSbloc bloc = ApiSbloc();

class ApiSbloc extends SimplifiedBloc {
  List<PostDataUiModel> posts = [];

  FutureOr<void> postInitialFetchEvent() async {
    addEvent(ApiEvents.postInitialFetchEvent);
    posts = await PostsRepo.fetchPosts();
    print("Is list updated..........?");
    print(posts.length);
    addEvent(ApiEvents.postDataLoad);
  }

  ///----here onEvent does not works-----------///

  // @override
  // onEvent(BlocEvent event) async {
  //   state = event;
  //   if (event == ApiEvents.postInitialFetchEvent) {
  //     posts = await PostsRepo.fetchPosts();
  //     print("Is list updated..........?");
  //     print(posts.length);
  //     // super.onState(ApiEvents.postInitialFetchEvent);
  //   }
  //   super.onEvent(event);
  // }
}
















































///------using sbloc simply-----///
// class CounterBloc extends SimplifiedBloc {
//   int count = 0;
//
//   Future<void> incrementCounter() async {
//     addEvent(CounterEvent.increment);
//   }
//
//   @override
//   onEvent(BlocEvent event) async {
//     if (event == CounterEvent.increment) {
//       super.onState(CounterEvent.incrementing);
//       await Future.delayed(const Duration(seconds: 1));
//       count++;
//       super.onState(CounterEvent.increment);
//     }
//     super.onEvent(event);
//   }
// }

///-----classical bloc way using state and events--------///
// class PostsBloc extends Bloc<PostsEvent, PostsState> {
//   PostsBloc() : super(PostsInitial()) {
//     on<PostsInitialFetchEvent>(postsInitialFetchEvent);
//     on<PostAddEvent>(postAddEvent);
//   }
//
//   FutureOr<void> postsInitialFetchEvent(
//       PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
//     emit(PostsFetchingLoadingState());
//     List<PostDataUiModel> posts = await PostsRepo.fetchPosts();
//
//     emit(PostFetchingSuccessfulState(posts: posts));
//   }
//
//   FutureOr<void> postAddEvent(
//       PostAddEvent event, Emitter<PostsState> emit) async {
//     bool success = await PostsRepo.addPost();
//
//     if (success) {
//       emit(PostsAdditionSuccessState());
//     } else {
//       emit(PostsAdditionErrorState());
//     }
//   }
// }
