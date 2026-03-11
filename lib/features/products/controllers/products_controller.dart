import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_url.dart';
import '../../../core/network/network_caller.dart';
import '../../../core/network/network_response.dart';
import '../models/product_model.dart';

enum ProductsState { initial, loading, success, error, empty }

class ProductsController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();
  final ScrollController scrollController = ScrollController();

  final RxList<ProductModel> products = <ProductModel>[].obs;
  final Rx<ProductsState> state = ProductsState.initial.obs;
  final RxBool isPaginationLoading = false.obs;
  final RxString errorMessage = ''.obs;

  static const int _limit = 10;
  int _skip = 0;
  int _total = 0;
  bool _isFetching = false;

  bool get hasMore => products.length < _total;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
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
        fetchMoreProducts();
      }
    }
  }

  Future<void> fetchProducts({bool refresh = false}) async {
    if (refresh) {
      _skip = 0;
      _total = 0;
      products.clear();
    }
    _isFetching = true;
    state.value = ProductsState.loading;
    errorMessage.value = '';

    final NetworkResponse response = await _networkCaller.getRequest(
      AppUrl.products(limit: _limit, skip: 0),
    );

    _isFetching = false;

    if (response.isSuccess && response.jsonResponse != null) {
      final List<dynamic> data = response.jsonResponse!['products'] ?? <dynamic>[];
      _total = response.jsonResponse!['total'] ?? 0;
      _skip = data.length;

      final List<ProductModel> fetched =
          data.map((dynamic e) => ProductModel.fromJson(e)).toList();

      products.assignAll(fetched);
      state.value = fetched.isEmpty ? ProductsState.empty : ProductsState.success;
    } else {
      state.value = ProductsState.error;
      errorMessage.value = response.errorMessage ?? 'Failed to load products.';
    }
  }

  Future<void> fetchMoreProducts() async {
    if (_isFetching || !hasMore) return;
    _isFetching = true;
    isPaginationLoading.value = true;

    final NetworkResponse response = await _networkCaller.getRequest(
      AppUrl.products(limit: _limit, skip: _skip),
    );

    isPaginationLoading.value = false;
    _isFetching = false;

    if (response.isSuccess && response.jsonResponse != null) {
      final List<dynamic> data = response.jsonResponse!['products'] ?? <dynamic>[];
      _skip += data.length;
      final List<ProductModel> fetched =
          data.map((dynamic e) => ProductModel.fromJson(e)).toList();
      products.addAll(fetched);
    }
  }
}
