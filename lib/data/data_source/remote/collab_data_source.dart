import 'package:dio/dio.dart';
import 'package:mycra_timesheet_app/data/models/collab_model.dart';
import 'package:retrofit/retrofit.dart';

part 'collab_data_source.g.dart';

@RestApi()
abstract class CollabRemoteDataSource {
  factory CollabRemoteDataSource(Dio dio) = _CollabRemoteDataSource;

  @GET('/collab/all')
  Future<List<CollabModel>> getAllCollabs();
}
