import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/auth/role_selection_screen.dart';
import 'screens/admin/admin_dashboard_screen.dart';
import 'screens/member/member_dashboard_screen.dart';
import 'core/providers/auth_provider.dart';

// Global navigator key for navigation from anywhere in the app
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CampaignConnect',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends ConsumerStatefulWidget {
  const AuthWrapper({super.key});

  @override
  ConsumerState<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends ConsumerState<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    // Check if user is logged in using cached data
    final isLoggedInAsync = ref.watch(isLoggedInProvider);
    final userTypeAsync = ref.watch(userTypeProvider);

    return isLoggedInAsync.when(
      data: (isLoggedIn) {
        if (isLoggedIn) {
          // User is logged in, check user type and navigate accordingly
          return userTypeAsync.when(
            data: (userType) {
              if (userType == 'MEMBER') {
                // Navigate to member dashboard
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MemberDashboardScreen(),
                      ),
                    );
                  }
                });
              } else {
                // Navigate to admin dashboard for any other user type
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminDashboardScreen(),
                      ),
                    );
                  }
                });
              }
              // Show loading while navigating
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            loading: () => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            error: (_, __) => const RoleSelectionScreen(),
          );
        } else {
          // User is not logged in, show role selection screen
          return const RoleSelectionScreen();
        }
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, __) => const RoleSelectionScreen(),
    );
  }
}

