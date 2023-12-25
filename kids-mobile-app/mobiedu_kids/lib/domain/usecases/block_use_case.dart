import 'package:mobiedu_kids/app/usecases/pram_usecase.dart';
import 'package:mobiedu_kids/domain/entities/blocks.dart';
import 'package:mobiedu_kids/domain/entities/profile.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/repositories/block_repository.dart';

class ListBlockUseCase extends ParamUseCase<ResponseDataObject<Blocks>, int> {
  ListBlockUseCase(this.blockRepository);

  final BlockRepository blockRepository;

  @override
  Future<ResponseDataObject<Blocks>> execute(params) {
    return blockRepository.list(params);
  }
}

class UnblockUseCase extends ParamUseCase<ResponseDataObject<Profile>, String> {
  UnblockUseCase(this.blockRepository);

  final BlockRepository blockRepository;

  @override
  Future<ResponseDataObject<Profile>> execute(params) {
    return blockRepository.unblock(params);
  }
}
