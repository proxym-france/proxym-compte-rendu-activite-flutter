import 'package:mycra_timesheet_app/data/data_source/remote/project_data_source.dart';
import 'package:mycra_timesheet_app/domain/entity/project.dart';
import 'package:mycra_timesheet_app/domain/repository/project_repo.dart';

class ProjectRepoImpl implements ProjectRepo {
  ProjectRepoImpl(this.dataSource);

  ProjectRemoteDataSource dataSource;

  @override
  Future<List<Project>> getProjectsByUser(String id) async {
    final result = await dataSource.getProjectByUser(id);
    return result.map((e) => Project.fromModel(e)).toList();
  }
}
