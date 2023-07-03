import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopsavvy/core/model/beer_model.dart';
import 'package:shopsavvy/core/repository/product_repository.dart';
import 'package:shopsavvy/presentation/home/controller/home_bloc.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  group('HomeBloc', () {
    const mockBeers = [
      Beer(
        id: 1,
        name: 'name',
        tagline: 'tagline',
        firstBrewed: 'firstbrewed',
        description: 'description',
        imageUrl: 'imageurl',
        abv: 'abv',
        ibu: 'ibu',
        targetFg: 'targetFg',
        targetOg: 'targetOg',
        ebc: 'ebc',
        srm: 'srm',
        ph: 'ph',
        attenuationLevel: 'attenuationLevel',
      )
    ];
    const extraMockBeers = [
      Beer(
        id: 2,
        name: 'name',
        tagline: 'tagline',
        firstBrewed: 'firstbrewed',
        description: 'description',
        imageUrl: 'imageurl',
        abv: 'abv',
        ibu: 'ibu',
        targetFg: 'targetFg',
        targetOg: 'targetOg',
        ebc: 'ebc',
        srm: 'srm',
        ph: 'ph',
        attenuationLevel: 'attenuationLevel',
      )
    ];

    late ProductRepository productRepository;

    setUpAll(() {
      registerFallbackValue(Uri());
    });

    setUp(() {
      productRepository = MockProductRepository();
    });

    test('initial state is HomeState()', () {
      expect(HomeBloc(productRepository: productRepository).state,
          const HomeState());
    });

    group('BeersFetched', () {
      blocTest<HomeBloc, HomeState>(
        'emits nothing when Beers list has reached maximum amount',
        build: () => HomeBloc(productRepository: productRepository),
        seed: () => const HomeState(hasReachedMax: true),
        act: (bloc) => bloc.add(FetchItems()),
        expect: () => <HomeState>[],
      );

      blocTest<HomeBloc, HomeState>(
        'emits successful status when http fetches initial beers',
        setUp: () {
          when(
            () => productRepository.fetchProductList(any()),
          ).thenAnswer((_) => Future.value(mockBeers));
        },
        build: () => HomeBloc(productRepository: productRepository),
        act: (bloc) => bloc.add(FetchItems()),
        expect: () => const <HomeState>[
          HomeState(
              status: FetchStatus.success, beers: mockBeers, pageNumber: 2)
        ],
        verify: (_) {
          verify(() => productRepository.fetchProductList(any())).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'drops new events when processing current event',
        setUp: () {
          when(
            () => productRepository.fetchProductList(any()),
          ).thenAnswer((_) => Future.value(mockBeers));
        },
        build: () => HomeBloc(productRepository: productRepository),
        act: (bloc) => bloc
          ..add(FetchItems())
          ..add(FetchItems()),
        expect: () => const <HomeState>[
          HomeState(
              status: FetchStatus.success, beers: mockBeers, pageNumber: 2)
        ],
        verify: (_) {
          verify(() => productRepository.fetchProductList(any())).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'throttles events',
        setUp: () {
          when(
            () => productRepository.fetchProductList(any()),
          ).thenAnswer((_) => Future.value(mockBeers));
        },
        build: () => HomeBloc(productRepository: productRepository),
        act: (bloc) async {
          bloc.add(FetchItems());
          await Future<void>.delayed(Duration.zero);
          bloc.add(FetchItems());
        },
        expect: () => const <HomeState>[
          HomeState(
              status: FetchStatus.success, beers: mockBeers, pageNumber: 2)
        ],
        verify: (_) {
          verify(() => productRepository.fetchProductList(any())).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits failure status when http fetches beers and throw exception',
        setUp: () {
          when(
            () => productRepository.fetchProductList(any()),
          ).thenAnswer(
            (_) async => throw Exception(" network error occoured"),
          );
        },
        build: () => HomeBloc(productRepository: productRepository),
        act: (bloc) => bloc.add(FetchItems()),
        expect: () => <HomeState>[
          const HomeState(
            status: FetchStatus.failure,
            errorMessage: "Exception:  network error occoured",
          )
        ],
        verify: (_) {
          verify(() => productRepository.fetchProductList(any())).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits successful status and reaches max beers when '
        '0 additional beers are fetched',
        setUp: () {
          when(
            () => productRepository.fetchProductList(any()),
          ).thenAnswer(
            (_) async => [],
          );
        },
        build: () => HomeBloc(productRepository: productRepository),
        seed: () => HomeState(
          status: FetchStatus.success,
          beers: mockBeers,
        ),
        act: (bloc) => bloc.add(FetchItems()),
        expect: () => const <HomeState>[
          HomeState(
            status: FetchStatus.success,
            beers: mockBeers,
            hasReachedMax: true,
          ),
        ],
        verify: (_) {
          verify(() => productRepository.fetchProductList(any())).called(1);
        },
      );

      blocTest<HomeBloc, HomeState>(
        'emits successful status and does not reach max beers '
        'when additional beers are fetched',
        setUp: () {
          when(
            () => productRepository.fetchProductList(any()),
          ).thenAnswer((_) => Future.value(extraMockBeers));
        },
        build: () => HomeBloc(productRepository: productRepository),
        seed: () => const HomeState(
          status: FetchStatus.success,
          beers: mockBeers,
        ),
        act: (bloc) => bloc.add(FetchItems()),
        expect: () => const <HomeState>[
          HomeState(
            status: FetchStatus.success,
            beers: [...mockBeers, ...extraMockBeers],
            pageNumber: 2,
          )
        ],
        verify: (_) {
          verify(() => productRepository.fetchProductList(any())).called(1);
        },
      );
    });
  });
}
