import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_url.dart';
import '../../../core/network/network_caller.dart';
import '../../../core/network/network_response.dart';
import '../models/post_model.dart';

enum PostsState { initial, loading, success, error, empty }

class PostsController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();
  final ScrollController scrollController = ScrollController();

  final RxList<PostModel> posts = <PostModel>[].obs;
  final Rx<PostsState> state = PostsState.initial.obs;
  final RxBool isPaginationLoading = false.obs;
  final RxString errorMessage = ''.obs;

  static const int _limit = 10;
  int _skip = 0;
  int _total = 0;
  bool _isFetching = false;

  bool get hasMore => posts.length < _total;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      if (!_isFetching && hasMore) {
        fetchMorePosts();
      }
    }
  }

  Future<void> fetchPosts({bool refresh = false}) async {
    if (refresh) {
      _skip = 0;
      _total = 0;
      posts.clear();
    }
    _isFetching = true;
    state.value = PostsState.loading;
    errorMessage.value = '';

    final NetworkResponse response = await _networkCaller.getRequest(
      AppUrl.posts(limit: _limit, skip: 0),
    );

    _isFetching = false;

    if (response.isSuccess && response.jsonResponse != null) {
      final List<dynamic> data = response.jsonResponse!['posts'] ?? <dynamic>[];
      _total = response.jsonResponse!['total'] ?? 0;
      _skip = data.length;

      final List<PostModel> fetched =
          data.map((dynamic e) => PostModel.fromJson(e)).toList();

      posts.assignAll(fetched);
      state.value = fetched.isEmpty ? PostsState.empty : PostsState.success;
    } else {
      state.value = PostsState.error;
      errorMessage.value = response.errorMessage ?? 'Failed to load posts.';
    }
  }

  Future<void> fetchMorePosts() async {
    if (_isFetching || !hasMore) return;
    _isFetching = true;
    isPaginationLoading.value = true;

    final NetworkResponse response = await _networkCaller.getRequest(
      AppUrl.posts(limit: _limit, skip: _skip),
    );

    isPaginationLoading.value = false;
    _isFetching = false;

    if (response.isSuccess && response.jsonResponse != null) {
      final List<dynamic> data = response.jsonResponse!['posts'] ?? <dynamic>[];
      _skip += data.length;
      final List<PostModel> fetched =
          data.map((dynamic e) => PostModel.fromJson(e)).toList();
      posts.addAll(fetched);
    }
  }
}
