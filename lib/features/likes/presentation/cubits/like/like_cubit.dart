import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/features/likes/data/model/like_model.dart';
import 'package:find_me_app/features/likes/data/repo/like_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'like_state.dart';

class LikeCubit extends Cubit<LikeState> {
  final LikeRepo repo;

  LikeCubit(this.repo) : super(const LikeState());

  /// ✅ load initial like status
  void loadInitialState(bool isLiked, int count) {
    emit(state.copyWith(
      status: LikeStatus.success,
      success: LikeResponse(
        message: '',
        isLiked: isLiked,
        likesCount: count,
      ),
    ));
  }

  /// 🔁 toggle like and update state
  Future<void> toggleLike(String id) async {
    emit(state.copyWith(status: LikeStatus.loading));

    final result = await repo.toggleLike(id);

    result.fold(
      (failure) => emit(state.copyWith(
        status: LikeStatus.error,
        error: failure,
      )),
      (response) => emit(state.copyWith(
        status: LikeStatus.success,
        success: response,
        error: null,
      )),
    );
  }
}
