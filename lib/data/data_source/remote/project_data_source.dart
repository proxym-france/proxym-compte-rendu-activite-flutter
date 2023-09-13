import 'package:dio/dio.dart';
import 'package:mycra_timesheet_app/data/models/project_model.dart';
import 'package:retrofit/retrofit.dart';

part 'project_data_source.g.dart';

@RestApi()
abstract class ProjectRemoteDataSource {
  factory ProjectRemoteDataSource(Dio dio) = _ProjectRemoteDataSource;

  @GET('/project/user/{id}')
  Future<List<ProjectModel>> getProjectByUser(@Path('id') String id);
}
