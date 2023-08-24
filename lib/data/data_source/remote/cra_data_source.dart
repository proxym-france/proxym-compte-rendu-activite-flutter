import 'package:dio/dio.dart';
import 'package:mycra_timesheet_app/data/models/cra_model.dart';
import 'package:retrofit/retrofit.dart';

part 'cra_data_source.g.dart';

@RestApi()
abstract class CraRemoteDataSource {
  factory CraRemoteDataSource(Dio dio) => _CraRemoteDataSource(dio);

  @GET('/cra/get/{user}/{month}/{year}')
  Future<CraModel> getCurrentCraPerUser(@Path() String user, @Path() int month, @Path() int year);
}
