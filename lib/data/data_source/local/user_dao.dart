import 'package:hive_flutter/hive_flutter.dart';
import 'package:mycra_timesheet_app/data/models/type/collab_type.dart';

abstract class CollabDao {
  Future<void> init();

  Future<void> saveCurrentCollab(CollabType collab);

  Future<CollabType?> getCurrentCollab();

  Future<void> clearCurrentCollab();
}

class CollabDaoImpl implements CollabDao {
  Box<CollabType>? collabBox;

  @override
  Future<void> init() async {
    collabBox = await Hive.openBox<CollabType>('collab');
  }

  @override
  Future<void> clearCurrentCollab() async {
    await collabBox?.clear();
  }

  @override
  Future<CollabType?> getCurrentCollab() async {
    if (collabBox == null) {
      await init();
      return getCurrentCollab();
    } else {
      return /**/ collabBox?.isEmpty == true ? null : collabBox?.getAt(0);
    }
  }

  @override
  Future<void> saveCurrentCollab(CollabType collab) async {
    if (collabBox?.isEmpty == true) {
      await collabBox?.add(collab);
    } else {
      await collabBox?.putAt(0, collab);
    }
  }
}
