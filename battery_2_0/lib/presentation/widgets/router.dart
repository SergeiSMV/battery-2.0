
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/user/device_impl.dart';
import '../view/logistic/logistic.dart';
import '../view/logistic/sim_storage/selected_item/selected_item.dart';
import '../view/logistic/sim_storage/sim_catalog.dart';
import '../view/logistic/sim_storage/sim_storage.dart';
import '../view/users/all_users.dart';
import '../view/home.dart';
import '../view/login.dart';
import '../view/users/selected_user.dart';

final router = GoRouter(
  initialLocation: DeviceImpl().getSavedDeviceId() == 'Empty' ? '/' : '/home',
  routes: [
    GoRoute(
      path: '/',
      builder: ((context, state) => const Login()),
    ),
    GoRoute(
      path: '/home',
      builder: ((context, state) => const Home()),
    ),
    GoRoute(
      path: '/all_users',
      builder: ((context, state) => const AllUsers()),
      routes: [
        GoRoute(
          path: 'selected_user/:id/:name/:surname/:patronymic/:position/:department',
          name: 'selected_user',
          builder: ((context, state) => SelectedUser(
            userId: '${state.pathParameters['id']}',
            name: '${state.pathParameters['name']}',
            surname: '${state.pathParameters['surname']}',
            patronymic: '${state.pathParameters['patronymic']}',
            position: '${state.pathParameters['position']}',
            department: '${state.pathParameters['department']}',
            )
          ),
        ),
      ]
    ),
    GoRoute(
      path: '/logistic',
      builder: ((context, state) => const Logistic()),
      routes: [
        GoRoute(
          path: 'sim',
          builder: ((context, state) => const SimStorage()),
          routes: [
            GoRoute(
              path: 'orders',
              builder: ((context, state) => const Home()),
            ),
            GoRoute(
              path: 'admission',
              builder: ((context, state) => const Home()),
            ),
            GoRoute(
              path: 'catalog',
              builder: ((context, state) => const SimCatalog()),
              routes: [
                GoRoute(
                  path: 'selected_item/:itemId',
                  name: 'selected_item',
                  builder: ((context, state) => SelectedItem(
                    itemId: '${state.pathParameters['itemId']}',
                    simCatalogContext: state.extra as BuildContext
                  )),
                ),
              ]
            ),
            GoRoute(
              path: 'catalog',
              builder: ((context, state) => const Home()),
            ),
            GoRoute(
              path: 'identification',
              builder: ((context, state) => const Home()),
            ),
          ]
        ),
      ]
    ),
  ]
);