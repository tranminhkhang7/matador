import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

enum Gender { male, female }

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _pickedDate;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();
  Gender? _gender;
  @override
  void initState() {
    final user = context.read<UserProvider>().account;
    _nameController.text = user.name;
    _passwordController.text = user.password;
    _addressController.text = user.token;
    _emailController.text = user.email;
    _birthdateController.text = user.birthDate == null
        ? DateFormat('dd-MM-yyyy').format(DateTime.now())
        : DateFormat('dd-MM-yyyy').format(user.birthDate!);
    _gender = user.gender == 'male' ? Gender.male : Gender.female;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        elevation: 0,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.5,
                        color: Colors.black54,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          AssetImage('assets/images/account_image.jpg'),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.camera_alt),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          prefixIcon: Icon(
                            Icons.person_outline_outlined,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        controller: _nameController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.key_outlined)),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        controller: _passwordController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Address', prefixIcon: Icon(Icons.home)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                        controller: _addressController,
                      ),
                      TextFormField(
                        controller: _birthdateController,
                        readOnly: true,
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _pickedDate ??
                                DateTime.tryParse(_birthdateController.text) ??
                                DateTime.now(),
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
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                            )),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        controller: _emailController,
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: RadioListTile<Gender>(
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
                      SizedBox(height: 25),
                      AppButton(
                        label: 'Save',
                        onPressed: () => _submitForm,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Save the user information to the database or API
    }
  }
}
