import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:find_me_app/features/navigation_bar_host/presentation/pages/host.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScope extends StatelessWidget {
  const HomeScope({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AllCasesCubit(sl())..onInit(),
      child: const HostView(currentIndex: 0),
    );
  }
}
