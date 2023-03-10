import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_textfield.dart';
import 'package:grocery_app/services/auth_service.dart';
import 'package:grocery_app/styles/colors.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterScreen extends StatefulWidget {
  final Function? callback;
  const RegisterScreen({super.key, this.callback});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with AutomaticKeepAliveClientMixin {
  final _signUpFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool _isFilled;
  bool _isLoading = false;
  final AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    setFilled();
    _emailController.addListener(setFilled);
    _passwordController.addListener(setFilled);
  }

  void setFilled() async {
    ((_emailController.text.isEmpty) || (_passwordController.text.isEmpty))
        ? _isFilled = true
        : _isFilled = false;
    setState(() {});
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    FocusManager.instance.primaryFocus?.unfocus();
    await authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scrollbar(
        child: GlowingOverscrollIndicator(
          showTrailing: true,
          axisDirection: AxisDirection.down,
          color: AppColors.primaryColor,
          child: ModalProgressHUD(
            inAsyncCall: _isLoading,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 3.0,
                            ),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppTextField(
                        isObscure: false,
                        controller: _emailController,
                        hintText: "Nh???p Email",
                        inputType: TextInputType.emailAddress,
                        prefixIcons: const Icon(Icons.email),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 3.0,
                            ),
                            child: Text(
                              'M???t kh???u',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppTextField(
                        isObscure: true,
                        controller: _passwordController,
                        hintText: "Nh???p M???t Kh???u",
                        prefixIcons: const Icon(Icons.key),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      AppButton(
                        onPressed: () {
                          if (_signUpFormKey.currentState!.validate()) {
                            signUpUser();
                          }
                        },
                        label: "????ng k??",
                        padding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
