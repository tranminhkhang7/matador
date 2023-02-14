import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_textfield.dart';
import 'package:grocery_app/constants/routes_constraints.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginView extends StatefulWidget {
  final Function? callback;
  const LoginView({
    Key? key,
    this.callback,
  }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool _isFilled;
  late bool _passwordNotVisible;
  bool _isLoading = false;
  double opacity = 1.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setFilled();
    _emailController.addListener(setFilled);
    _passwordController.addListener(setFilled);
    _passwordNotVisible = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void setFilled() {
    ((_emailController.text.isEmpty) || (_passwordController.text.isEmpty))
        ? _isFilled = true
        : _isFilled = false;
    setState(() {});
  }

  void _submit() {
    setState(() {
      _isLoading = true;
    });
    FocusManager.instance.primaryFocus?.unfocus();
    //Simulate a service call
    print('submitting to backend...');
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        _isLoading = false;
      });

      widget.callback!(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GlowingOverscrollIndicator(
        showTrailing: true,
        axisDirection: AxisDirection.down,
        color: AppColors.primaryColor,
        child: ModalProgressHUD(
          inAsyncCall: _isLoading,
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                child: Form(
                  key: _signInFormKey,
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
                        inputType: TextInputType.emailAddress,
                        isObscure: false,
                        controller: _emailController,
                        hintText: "Nhập Email",
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
                              'Mật khẩu',
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
                        isObscure: _passwordNotVisible,
                        controller: _passwordController,
                        hintText: "Nhập Mật khẩu",
                        prefixIcons: const Icon(Icons.key),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordNotVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordNotVisible = !_passwordNotVisible;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Material(
                            color: Colors.transparent,
                            shadowColor: Colors.transparent,
                            child: Ink(
                              child: InkWell(
                                splashColor: AppColors.lightGrey,
                                onTapDown: (TapDownDetails details) {
                                  opacity = 0.5;
                                  setState(() {});
                                  //print("tapped");
                                },
                                onTapUp: (TapUpDetails details) async {
                                  opacity = 1.0;
                                  await Future.delayed(
                                    const Duration(
                                      milliseconds: 200,
                                    ),
                                  );
                                  setState(() {});
                                },
                                child: AnimatedOpacity(
                                  opacity: opacity,
                                  duration: const Duration(milliseconds: 200),
                                  child: const Text(
                                    'Quên mật khẩu?',
                                    style: TextStyle(
                                      color: AppColors.secondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      AppButton(
                        label: "Đăng nhập",
                        onPressed: () {
                          if (_signInFormKey.currentState!.validate())
                            _submit();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 20.0),
                              child: const Divider(
                                color: Colors.black45,
                                height: 36,
                              ),
                            ),
                          ),
                          const Text(
                            "HOẶC",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black45,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 20.0),
                              child: const Divider(
                                color: Colors.black45,
                                height: 36,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppButtonWithIcon(
                        label: "Tiếp tục với Google",
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
}
