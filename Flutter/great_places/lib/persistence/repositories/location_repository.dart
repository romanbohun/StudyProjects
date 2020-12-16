import 'base_repository.dart';
import '../../places/models/location.dart';

class LocationRepository extends BaseRepository {
  LocationRepository() : super(Location().tableName);
}