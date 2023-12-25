import 'package:qltv/domain/entities/lend_mid_data.dart';
import '../entities/mid_array_data.dart';
import '../entities/response_data_object.dart';

abstract class LendingRepository {
  Future<ResponseDataObject<MidArrayData<LendingMidData>>> fetchLending();
}