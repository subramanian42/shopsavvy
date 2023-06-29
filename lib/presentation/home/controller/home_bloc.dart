import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsavvy/core/repository/product_repository.dart';

import '../../../core/model/beer_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository productRepository;
  HomeBloc({
    required this.productRepository,
  }) : super(HomeState()) {
    on<FetchItems>(_onFetchItems);
  }
  void _onFetchItems(FetchItems event, Emitter<HomeState> emit) async {
    try {
      if (state.hasReachedMax) return;
      if (state.status == FetchStatus.initial) {
        final productList =
            await productRepository.fetchProductList(state.pageNumber);
        emit(
          state.copyWith(
            status: FetchStatus.success,
            pageNumber: state.pageNumber + 1,
            beers: productList,
            hasReachedMax: false,
          ),
        );
      }
      final productList =
          await productRepository.fetchProductList(state.pageNumber);
      emit(
        productList.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: FetchStatus.success,
                pageNumber: state.pageNumber + 1,
                beers: List.of(state.beers)..addAll(productList),
                hasReachedMax: false,
              ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: FetchStatus.failure,
        ),
      );
    }
  }
}
