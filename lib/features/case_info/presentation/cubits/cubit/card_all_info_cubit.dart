// import 'package:equatable/equatable.dart';
// import 'package:find_me_app/features/case_info/data/models/all_case_info.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'card_all_info_state.dart';

// class CardAllInfoCubit extends Cubit<CardAllInfoState> {
//   List<AllCaseInfo> allcases = [
//     AllCaseInfo(
//       name: "Mariam Ali",
//       location: "Egypt, Cairo",
//       imageUrl: 'https://i.pravatar.cc/120?img=12',
//       id: "1",
//       height: 160.0,
//       eyeColor: "black",
//       skinColor: "white",
//       hairColor: "yollow",
//     ),
//     AllCaseInfo(
//       name: "Khaled Safwat",
//       location: "Egypt, Qalyubia",
//       imageUrl: 'https://i.pravatar.cc/120?img=18',
//       id: "2",
//       height: 160.0,
//       eyeColor: "black",
//       skinColor: "white",
//       hairColor: "yollow",
//     ),
//     AllCaseInfo(
//       name: "Youssef Ahmed",
//       location: "Egypt, Gharbia",
//       imageUrl: 'https://i.pravatar.cc/120?img=7',
//       id: "3",
//       height: 160.0,
//       eyeColor: "black",
//       skinColor: "white",
//       hairColor: "yollow",
//     ),
//   ];

//   CardAllInfoCubit()
//       : super(CardAllInfoState(status: CardAllInfoStateStatus.initial));

//   void toggleFavoriteCard(String caseId) {
//     AllCaseInfo? selectedCard;
//     allcases.map((c) {
//       if (c.id == caseId) {
//         selectedCard = c;
//       }
//     });
//     emit(state.copyWith(selectedCard: selectedCard));
//   }
// }
