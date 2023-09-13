import 'package:mycra_timesheet_app/domain/entity/project.dart';

abstract class ProjectRepo {
  Future<List<Project>> getProjectsByUser(String id);
}
