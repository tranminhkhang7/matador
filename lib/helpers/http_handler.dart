import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:grocery_app/helpers/snackbar.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body));
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    case 403:
    case 401:
      showSnackBar(context, 'Session time out');
      break;
    default:
      showSnackBar(context, (response.body));
  }
}
