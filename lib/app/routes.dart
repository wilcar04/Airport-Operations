import 'package:airport_operations/features/alerts/alerts_screen.dart';
import 'package:airport_operations/features/energy/energy_screen.dart';
import 'package:airport_operations/features/operations/operations_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/operations',
  routes: [
    GoRoute(
      path: '/operations',
      name: 'operations',
      builder: (BuildContext context, GoRouterState state) {
        return OperationsScreen();
      },
    ),
    GoRoute(
      path: '/energy',
      name: 'energy',
      builder: (BuildContext context, GoRouterState state) {
        return EnergyScreen();
      },
    ),
    GoRoute(
      path: '/alerts',
      name: 'alerts',
      builder: (BuildContext context, GoRouterState state) {
        return AlertsScreen();
      },
    ),
  ],
);
