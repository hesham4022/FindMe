part of 'like_cubit.dart';

enum LikeStatus { initial, loading, success, error }

class LikeState extends Equatable {
  final LikeStatus status;
  final Failure? error;
  final LikeResponse? success;

  const LikeState({
    this.status = LikeStatus.initial,
    this.error,
    this.success,
  });

  LikeState copyWith({
    LikeStatus? status,
    Failure? error,
    LikeResponse? success,
  }) {
    return LikeState(
      status: status ?? this.status,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props => [status, error, success];
}
