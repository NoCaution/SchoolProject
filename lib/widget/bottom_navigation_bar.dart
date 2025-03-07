
import 'package:edirne_gezgini_ui/bloc/favorites_bloc/favorites_event.dart';
import 'package:edirne_gezgini_ui/bloc/home_bloc/home_navigator_cubit.dart';
import 'package:edirne_gezgini_ui/bloc/visitations_bloc/visitations_bloc.dart';
import 'package:edirne_gezgini_ui/bloc/visitations_bloc/visitations_event.dart';
import 'package:edirne_gezgini_ui/view/favorites_page.dart';
import 'package:edirne_gezgini_ui/view/get_route_page.dart';
import 'package:edirne_gezgini_ui/view/visitations_page.dart';
import 'package:flutter/material.dart';
import 'package:edirne_gezgini_ui/constants.dart' as constants;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bottom_nav_bar_cubit.dart';
import '../bloc/favorites_bloc/favorites_bloc.dart';
import '../bloc/home_bloc/home_navigator.dart';

class BottomNavBar extends StatelessWidget {
  final HomeNavigatorCubit homeNavigatorCubit;

  BottomNavBar({super.key, required this.homeNavigatorCubit});

  int tapCount = 0;
  int tapCount2 = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BottomNavBarCubit(),
        child: BlocBuilder<BottomNavBarCubit, int>(builder: (context, state) {
          return Scaffold(
              body: IndexedStack(
                index: state,
                children: const [
                  HomeNavigator(),
                  FavoritePage(),
                  VisitationsPage(),
                  GetRoutePage(),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: constants.bottomNavBarColor.withOpacity(0.9),
                currentIndex: state,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                onTap: (index) {
                  context.read<BottomNavBarCubit>().selectIndex(index);
                  if (state == 0) {
                    homeNavigatorCubit.showHome();
                  }

                  if(state == 1) {
                    tapCount = tapCount + 1;
                    if(tapCount == 1 || tapCount/4 == 1) {
                      BlocProvider.of<FavoritesBloc>(context).add(GetFavoriteList());
                    }
                  }
                  if(state == 2) {
                    tapCount2 = tapCount2 + 1;
                    if(tapCount2 == 1 || tapCount2/4 == 1) {
                      BlocProvider.of<VisitationsBloc>(context).add(GetVisitationList());
                    }
                  }
                },
                items: [home(), favorites(), visitations(), getRoute()],
              ));
        }));
  }
}

BottomNavigationBarItem home() {
  return const BottomNavigationBarItem(
      activeIcon: Icon(Icons.home),
      icon: Icon(Icons.home_outlined),
      label: "Ana Sayfa");
}

BottomNavigationBarItem favorites() {
  return const BottomNavigationBarItem(
      activeIcon: Icon(Icons.favorite),
      icon: Icon(Icons.favorite_border),
      label: "Favorilerim");
}

BottomNavigationBarItem visitations() {
  return const BottomNavigationBarItem(
      activeIcon: Icon(Icons.location_on_outlined),
      icon: Icon(Icons.location_on_outlined),
      label: "Gittiğim Yerler");
}

BottomNavigationBarItem getRoute() {
  return const BottomNavigationBarItem(
    activeIcon: Icon(Icons.map),
    icon: Icon(Icons.map_outlined),
    label: "Rota Göster",
  );
}
