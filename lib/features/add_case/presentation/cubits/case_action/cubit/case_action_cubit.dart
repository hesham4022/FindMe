import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'case_action_state.dart';

class CaseActionCubit extends Cubit<CaseActionState> {
  CaseActionCubit() : super(CaseActionInitial());
}
