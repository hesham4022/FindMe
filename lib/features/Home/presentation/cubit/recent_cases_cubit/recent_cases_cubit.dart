import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recent_cases_state.dart';

class RecentCasesCubit extends Cubit<RecentCasesState> {
  RecentCasesCubit() : super(RecentCasesInitial());
}
