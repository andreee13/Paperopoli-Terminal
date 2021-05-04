import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:paperopoli_terminal/data/models/good_model.dart';
import 'package:paperopoli_terminal/data/repositories/goods_repository.dart';

part 'goods_state.dart';

class GoodsCubit extends Cubit<GoodsState> {
  final GoodsRepository repository;

  GoodsCubit({
    required this.repository,
  }) : super(
          GoodsInitial(),
        );
}
