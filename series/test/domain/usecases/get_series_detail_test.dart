import 'package:dartz/dartz.dart';
import 'package:series/domain/usecases/get_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/series_dummy_object.dart';
import '../../helpers/series_test_helper.mocks.dart';

void main() {
  late GetSeriesDetail usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetSeriesDetail(mockSeriesRepository);
  });

  final tId = 1;

  test('should get Series detail from the repository', () async {
    // arrange
    when(mockSeriesRepository.getSeriesDetail(tId))
        .thenAnswer((_) async => Right(testSeriesDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testSeriesDetail));
  });
}
