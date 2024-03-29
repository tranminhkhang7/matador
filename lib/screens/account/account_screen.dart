import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/constants/routes_constraints.dart';
import 'package:grocery_app/helpers/column_with_seprator.dart';
import 'package:grocery_app/providers/user_provider.dart';
import 'package:grocery_app/services/auth_service.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:provider/provider.dart';

import 'account_item.dart';

class AccountScreen extends StatefulWidget {
  final Function? callback;
  const AccountScreen({
    Key? key,
    this.callback,
  }) : super(key: key);
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final AuthService authService = AuthService();

  void navigateToUserProfile(BuildContext context, String location) {
    switch (location) {
      case "My Details":
        Navigator.pushNamed(
          context,
          RoutesHandler.USER_PROFILE,
        );
        break;
      case "Orders":
        Navigator.pushNamed(
          context,
          RoutesHandler.ORDERS,
        );
        break;
      default:
        break;
    }
  }

  void logout(BuildContext context) async {
    await authService.logout(context);
    widget.callback!();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).account;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading:
                      SizedBox(width: 65, height: 65, child: getImageHeader()),
                  title: AppText(
                    text: user.customer.name,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: AppText(
                    text: user.email,
                    color: Color(0xff7C7C7C),
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                Column(
                  children: getChildrenWithSeperator(
                    widgets: accountItems.map((e) {
                      return InkWell(
                        child: getAccountItemWidget(e),
                        onTap: () => navigateToUserProfile(context, e.label),
                      );
                    }).toList(),
                    seperator: Divider(
                      thickness: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                logoutButton(context),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logoutButton(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          elevation: 0,
          backgroundColor: Color(0xffF2F3F2),
          textStyle: TextStyle(
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 25),
          minimumSize: const Size.fromHeight(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                "assets/icons/account_icons/logout_icon.svg",
                color: AppColors.primaryColor,
              ),
            ),
            Text(
              "Log Out",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor),
            ),
            Container()
          ],
        ),
        onPressed: () => logout(context),
      ),
    );
  }

  Widget getImageHeader() {
    String imagePath = "assets/images/account_image.jpg";
    return CircleAvatar(
      radius: 5.0,
      backgroundImage: AssetImage(imagePath),
      backgroundColor: AppColors.primaryColor.withOpacity(0.7),
    );
  }

  Widget getAccountItemWidget(AccountItem accountItem) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset(
              accountItem.iconPath,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            accountItem.label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
