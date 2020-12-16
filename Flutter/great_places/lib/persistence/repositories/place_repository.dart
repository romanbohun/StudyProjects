import 'package:sqflite_common/sqlite_api.dart';

import 'base_repository.dart';
import '../abstractions/connection_abstract.dart';
import '../../places/models/place.dart';

class PlaceRepository extends BaseRepository {
  PlaceRepository() : super(Place().tableName);
}