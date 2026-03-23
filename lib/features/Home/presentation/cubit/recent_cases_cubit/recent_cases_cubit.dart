import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';

part 'recent_cases_state.dart';

class RecentCasesCubit extends Cubit<RecentCasesState> {
  RecentCasesCubit() : super(RecentCasesInitial());
}
