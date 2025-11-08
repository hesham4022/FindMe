import 'package:find_me_app/features/auth/presentation/pages/sinup_or_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/networking/network_info.dart';
import 'package:find_me_app/core/networking/network_state.dart';
import 'package:find_me_app/core/shared/widgets/no_connection_page.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:find_me_app/features/auth/presentation/pages/signin.dart';
import 'package:find_me_app/features/navigation_bar_host/presentation/pages/host.dart';

class MiddlewarePage extends StatelessWidget {
  const MiddlewarePage({super.key});

  @override
  Widget build(BuildContext context) {
    print(
        "sl<AuthLocal>().isUserLoggedIn() : ${sl<AuthLocal>().isUserLoggedIn()}");

    return BlocBuilder<NetworkInfo, NetworkState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is NetworkDisconnected) {
          return const NoConnectionPage();
        } else {
          return _getScreen(context);
        }
      },
    );
  }

  Widget _getScreen(BuildContext context) {
    // Sign In Screen
    if (sl<AuthLocal>().isUserLoggedIn() == false) {
      return const SinupOrLogin();
    }
    // HostView
    else {
      return const HostView(currentIndex: 0);
    }
  }
}
