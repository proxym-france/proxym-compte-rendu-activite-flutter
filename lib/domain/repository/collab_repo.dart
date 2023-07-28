import 'package:mycra_timesheet_app/domain/entity/collab.dart';

abstract class CollabRepo {
  ///  get all collabs
  ///  Returns a future [Collab]
  Future<List<Collab>> getAll();

  /// find collab by [id]
  /// Returns [Collab] if exists otherwise [Empty]
  Future<Collab> findById(String id);

  /// find list of collab by [ids]
  /// Returns only existing [Collab] list otherwise [Empty]
  Future<List<Collab>> findAllByIds(List<String> ids);
}
