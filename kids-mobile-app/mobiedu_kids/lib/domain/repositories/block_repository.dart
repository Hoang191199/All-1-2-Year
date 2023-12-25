import 'package:mobiedu_kids/domain/entities/blocks.dart';
import 'package:mobiedu_kids/domain/entities/profile.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';

abstract class BlockRepository {
  Future<ResponseDataObject<Blocks>> list(int page);
  Future<ResponseDataObject<Profile>> unblock(String friend_id);
}
