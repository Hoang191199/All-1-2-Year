import 'package:mobiedu_kids/data/providers/network/apis/block_api.dart';
import 'package:mobiedu_kids/domain/entities/blocks.dart';
import 'package:mobiedu_kids/domain/entities/profile.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/block_repository.dart';

class BlockRepositoryImpl extends BlockRepository {
  @override
  Future<ResponseDataObject<Blocks>> list(int page) async {
    final response = await BlockAPI.list(page).request();
    return ResponseDataObject<Blocks>.fromJson(
        response, (data) => Blocks.fromJson(data));
  }

  @override
  Future<ResponseDataObject<Profile>> unblock(String friend_id) async {
    final response = await BlockAPI.unblock(friend_id).request();
    return ResponseDataObject<Profile>.fromJson(
        response, (data) => Profile.fromJson(data));
  }
}
