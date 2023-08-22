import 'package:mycra_timesheet_app/data/data_source/remote/cra_data_source.dart';
import 'package:mycra_timesheet_app/domain/entity/CraCardModel.dart';
import 'package:mycra_timesheet_app/domain/entity/cra.dart';
import 'package:mycra_timesheet_app/domain/repository/cra_repo.dart';

class CraRepoImpl implements CraRepo {
  final CraRemoteDataSource craRemoteDataSource;

  CraRepoImpl(this.craRemoteDataSource);

  @override
  Future<List<CraCardModel>> fetchCurrentCraPerMonth(String user, int month, int year) async {
    final craModel = await craRemoteDataSource.getCurrentCraPerUser(user, month, year);
    return Cra.fromModel(craModel);
  }
}