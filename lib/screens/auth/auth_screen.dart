import 'package:flutter/material.dart';
import 'package:grocery_app/providers/user_provider.dart';
import 'package:grocery_app/screens/auth/login_screen.dart';
import 'package:grocery_app/screens/auth/register_screen.dart';
import 'package:grocery_app/screens/account/account_screen.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _tabController = TabController(
        length: 2,
        vsync: this,
      );
      _tabController.addListener(_handleTabSelection);
    }
  }

  callback() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      _page = _tabController.index;
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().account;
    return user.token.isNotEmpty
        ? AccountScreen(
            callback: callback,
          )
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: AppBar(
                  centerTitle: true,
                  elevation: 0,
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _page == 0 ? 'Log In' : "Sign up",
                        style: const TextStyle(
                          color: AppColors.scaffoldBackgroundColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TabBar(
                    unselectedLabelColor: Colors.black,
                    labelColor: AppColors.secondaryColor,
                    tabs: const [
                      Tab(
                        text: 'Log In',
                      ),
                      Tab(
                        text: 'Sign Up',
                      )
                    ],
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding:
                        const EdgeInsets.symmetric(horizontal: 10),
                    indicatorColor: AppColors.secondaryColor,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        LoginView(
                          callback: callback,
                        ),
                        RegisterScreen(
                          callback: callback,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
