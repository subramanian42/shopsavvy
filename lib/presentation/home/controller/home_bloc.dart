import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsavvy/core/repository/product_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../../core/model/beer_model.dart';
part 'home_event.dart';
part 'home_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository productRepository;
  HomeBloc({
    required this.productRepository,
  }) : super(HomeState()) {
    on<FetchItems>(
      _onFetchItems,
      transformer: throttleDroppable(throttleDuration),
    );
  }
  void _onFetchItems(FetchItems event, Emitter<HomeState> emit) async {
    try {
      if (state.hasReachedMax) return;
      if (state.status == FetchStatus.initial) {
        final productList =
            await productRepository.fetchProductList(state.pageNumber);
        return emit(
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
