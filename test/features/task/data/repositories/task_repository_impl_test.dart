import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:refocus_app/features/task/data/datasources/aws_data_source.dart';
import 'package:refocus_app/features/task/data/repositories/task_repository_impl.dart';
import 'package:refocus_app/features/task/domain/entities/project_entry.dart';
import 'package:refocus_app/models/ModelProvider.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockRemoteDataSource extends Mock implements TaskRemoteDataSource {}

void main() {
  late TaskRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = TaskRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('Project: ', () {
    final tProjectEntry = ProjectEntry.fromJson(fixture('project_entry.json'));
    final tProject = Project.fromJson(tProjectEntry.toMap());
    test(
      'should create new project and return the same project entry',
      () async {
        // arrange
        when(() => mockRemoteDataSource.createOrUpdateRemoteProject(tProject))
            .thenAnswer(
          (_) async => Future.value(),
        );
        // act
        final result = await repository.createProject(tProjectEntry);
        // assert
        expect(result, Right(tProjectEntry));
      },
    );
  });
}
