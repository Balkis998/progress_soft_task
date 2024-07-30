import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../Model/post_model.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  List<PostModel> _allPosts = [];

  PostBloc() : super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
    on<SearchPosts>(_onSearchPosts);
  }

  void _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        _allPosts = (json.decode(response.body) as List)
            .map((data) => PostModel.fromJson(data))
            .toList();
        emit(PostLoaded(_allPosts));
      } else {
        emit(PostError('Failed to load posts'));
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  void _onSearchPosts(SearchPosts event, Emitter<PostState> emit) {
    final query = event.query.toLowerCase();
    final filteredPosts = _allPosts.where((post) {
      final title = post.title.toLowerCase();
      return title.contains(query);
    }).toList();
    emit(PostLoaded(filteredPosts));
  }
}
