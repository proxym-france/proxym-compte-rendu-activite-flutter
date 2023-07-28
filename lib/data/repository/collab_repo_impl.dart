import 'package:flutter/cupertino.dart';
import 'package:mycra_timesheet_app/data/data_source/remote/collab_data_source.dart';
import 'package:mycra_timesheet_app/domain/entity/collab.dart';
import 'package:mycra_timesheet_app/domain/repository/collab_repo.dart';

class CollabRepoImpl extends ChangeNotifier implements CollabRepo {
  CollabRepoImpl(this.collabRemoteDataSource);

  CollabRemoteDataSource collabRemoteDataSource;

  @override
  Future<List<Collab>> findAllByIds(List<String> ids) {
    // TODO: implement findAllByIds
    throw UnimplementedError();
  }

  @override
  Future<Collab> findById(String id) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<List<Collab>> getAll() async {
    var list = await collabRemoteDataSource.getAllCollabs();
    return list.map((e) => Collab.fromModel(e)).toList();
  }
}
