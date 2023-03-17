import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_textfield.dart';
import 'package:grocery_app/screens/profile/user_profile.dart';
import 'package:grocery_app/services/auth_service.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:intl/intl.dart';

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
  DateTime? _pickedDate;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  Gender? _gender;

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
    _gender = Gender.male;
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
        name: _nameController.text,
        gender: _gender == Gender.male ? 'male' : 'female',
        address: _addressController.text,
        birthday: _pickedDate,
        phone: _phoneController.text);
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: const [
                      //     Padding(
                      //       padding: EdgeInsets.only(
                      //         left: 3.0,
                      //       ),
                      //       child: Text(
                      //         'Email',
                      //         style: TextStyle(
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //         textAlign: TextAlign.left,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        label: "Email",
                        isObscure: false,
                        controller: _emailController,
                        hintText: "Email",
                        inputType: TextInputType.emailAddress,
                        prefixIcons: const Icon(Icons.email),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: const [
                      //     Padding(
                      //       padding: EdgeInsets.only(
                      //         left: 3.0,
                      //       ),
                      //       child: Text(
                      //         'Password',
                      //         style: TextStyle(
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //         textAlign: TextAlign.left,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      AppTextField(
                        label: "Password",
                        isObscure: true,
                        controller: _passwordController,
                        hintText: "Password",
                        prefixIcons: const Icon(Icons.key),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        isObscure: false,
                        label: "Address",
                        controller: _addressController,
                        hintText: "Address",
                        prefixIcons: const Icon(Icons.home),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _birthdateController,
                        readOnly: true,
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate != null) {
                            setState(() {
                              _pickedDate = pickedDate;
                              _birthdateController.text =
                                  DateFormat('dd-MM-yyyy').format(_pickedDate!);
                            });
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Birthday',
                          hintText: 'Select your birthday',
                          prefixIcon: Icon(Icons.date_range),
                          contentPadding: const EdgeInsets.only(
                            left: 10.0,
                            top: 15.0,
                            bottom: 15.0,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black45,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        isObscure: false,
                        label: "Name",
                        controller: _nameController,
                        hintText: "Name",
                        prefixIcons: const Icon(Icons.person_outline_outlined),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        isObscure: false,
                        label: "Phone",
                        controller: _phoneController,
                        hintText: "Phone",
                        prefixIcons: const Icon(Icons.phone_outlined),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: RadioListTile<Gender>(
                                activeColor: AppColors.primaryColor,
                                title: const Text('Male'),
                                value: Gender.male,
                                groupValue: _gender,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: RadioListTile<Gender>(
                                activeColor: AppColors.primaryColor,
                                title: const Text('Female'),
                                value: Gender.female,
                                groupValue: _gender,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
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
                        label: "Sign Up",
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
