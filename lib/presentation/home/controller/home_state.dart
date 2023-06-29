part of 'home_bloc.dart';

enum FetchStatus { initial, success, failure }

class HomeState {
  final FetchStatus status;
  final bool hasReachedMax;
  final int pageNumber;
  final String? errorMessage;
  final List<Beer> beers;
  const HomeState({
    this.status = FetchStatus.initial,
    this.hasReachedMax = false,
    this.pageNumber = 1,
    this.beers = const [],
    this.errorMessage,
  });
  HomeState copyWith({
    FetchStatus? status,
    bool? hasReachedMax,
    int? pageNumber,
    List<Beer>? beers,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      beers: beers ?? this.beers,
      pageNumber: pageNumber ?? this.pageNumber,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage,
    );
  }
}
