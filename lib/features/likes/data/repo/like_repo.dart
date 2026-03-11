import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/features/likes/data/model/like_model.dart';
import 'package:find_me_app/features/likes/data/source/like_remote.dart';

class LikeRepo {
  final LikeRemote _likeRemote;

  LikeRepo(this._likeRemote);

  Future<Either<Failure, LikeResponse>> toggleLike(String id) {
    return executeFunctionality<LikeResponse>(
      function: () async {
        final response = await _likeRemote.likeInPost(id);
        return response;
      },
    );
  }
}
