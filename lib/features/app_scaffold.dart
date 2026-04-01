import 'package:airport_operations/app/colors.dart';
import 'package:airport_operations/features/widgets/airport_top_bar.dart';
import 'package:airport_operations/features/widgets/bottom_nav_index_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// ---------------------------------------------------------------------------
// AppScaffold
// ---------------------------------------------------------------------------

/// Shared scaffold wrapper for every top-level screen.
///
/// Provides:
/// - [AirportTopBar] as the `AppBar`
/// - [AirportBottomNavBar] with GoRouter navigation wired up
/// - Dark background colour + `extendBodyBehindAppBar`
///
/// Usage:
/// ```dart
/// class OperationsScreen extends ConsumerWidget {
///   @override
///   Widget build(BuildContext context, WidgetRef ref) {
///     return AppScaffold(
///       navIndex: 0,
///       body: SingleChildScrollView(...),
///     );
///   }
/// }
/// ```
class AppScaffold extends ConsumerWidget {
  const AppScaffold({super.key, required this.body});

  /// The scrollable/non-scrollable content of the screen.
  final Widget body;

  static const _routes = ['/operations', '/energy', '/alerts'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.path;
    final index = _routes
        .indexWhere((element) => location.startsWith(element))
        .clamp(0, _routes.length - 1);
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: const AirportTopBar(),
      bottomNavigationBar: AirportBottomNavBar(
        currentIndex: index,
        onTap: (i) {
          context.go(_routes[i]);
        },
      ),
      body: body,
    );
  }
}

// ---------------------------------------------------------------------------
// Convenience padding helper
// ---------------------------------------------------------------------------

/// Returns the standard content padding that accounts for the status bar and
/// the 64 px top bar. Use this as the `padding` for your [SingleChildScrollView].
EdgeInsets screenContentPadding(
  BuildContext context, {
  double horizontal = 16,
  double bottom = 24,
}) {
  return EdgeInsets.only(
    top: MediaQuery.of(context).padding.top + 64 + 24,
    left: horizontal,
    right: horizontal,
    bottom: bottom,
  );
}
