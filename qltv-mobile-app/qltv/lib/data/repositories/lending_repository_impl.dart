import 'package:qltv/domain/entities/lend_mid_data.dart';
import '../../domain/entities/mid_array_data.dart';
import '../../domain/entities/response_data_object.dart';
import '../../domain/repositories/lending_repository.dart';
import '../providers/network/apis/lending_api.dart';

class LendingRepositoryImpl extends LendingRepository {
  @override
  Future<ResponseDataObject<MidArrayData<LendingMidData>>>
      fetchLending() async {
    final response = await LendingAPI.fetchLending().request();
    return ResponseDataObject<MidArrayData<LendingMidData>>.fromJson(
        response,
        (data) => MidArrayData<LendingMidData>.fromJson(
            data, (d) => LendingMidData.fromJson(d)));
  }
}
