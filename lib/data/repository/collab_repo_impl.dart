import 'package:flutter/cupertino.dart';
import 'package:mycra_timesheet_app/core/exception/collab_not_found_exception.dart';
import 'package:mycra_timesheet_app/data/data_source/local/user_dao.dart';
import 'package:mycra_timesheet_app/data/data_source/remote/collab_data_source.dart';
import 'package:mycra_timesheet_app/data/models/type/collab_type.dart';
import 'package:mycra_timesheet_app/domain/entity/collab.dart';
import 'package:mycra_timesheet_app/domain/repository/collab_repo.dart';

class CollabRepoImpl extends ChangeNotifier implements CollabRepo {
  CollabRepoImpl(this.collabRemoteDataSource, this.collabDao);

  CollabRemoteDataSource collabRemoteDataSource;
  CollabDao collabDao;

  @override
  Future<List<Collab>> findAllByIds(List<String> ids) {
    // TODO: implement findAllByIds
    throw UnimplementedError();
  }

  @override
  Future<Collab> findById(String id) async {
    var list = await collabRemoteDataSource.getCollabByIds(id);
    if (list.isEmpty) throw CollabNotFoundException();
    return Collab.fromModel(list[0]);
  }

  @override
  Future<List<Collab>> getAll() async {
    var list = await collabRemoteDataSource.getAllCollabs();
    return list.map((e) => Collab.fromModel(e)).toList();
  }

  @override
  Future<void> saveCurrentCollab(Collab collab) async {
    collabDao.saveCurrentCollab(CollabType.fromEntity(collab));
  }

  @override
  Future<Collab?> getSavedCollab() async {
    final collab = await collabDao.getCurrentCollab();
    return (collab != null) ? Collab.fromType(collab) : null;
  }

  @override
  Future<void> clearSavedCollab() async {
    return await collabDao.clearCurrentCollab();
  }
}
