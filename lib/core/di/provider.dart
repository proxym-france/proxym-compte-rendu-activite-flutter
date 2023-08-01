import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycra_timesheet_app/core/dio/dio_factory.dart';
import 'package:mycra_timesheet_app/data/data_source/remote/collab_data_source.dart';
import 'package:mycra_timesheet_app/data/repository/collab_repo_impl.dart';
import 'package:mycra_timesheet_app/domain/repository/collab_repo.dart';

// const String _baseUrl = "http://10.188.91.30:8080";
const String _baseUrl = 'http://192.168.10.103:8080';

final dioProvider = Provider<Dio>(
  (ref) => DioFactory(_baseUrl).create(),
);

final collabDataSourceProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return CollabRemoteDataSource(dio);
});

final collabRepoProvider = Provider<CollabRepo>(
    (ref) => CollabRepoImpl(ref.read(collabDataSourceProvider)));
