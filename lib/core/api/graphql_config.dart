import 'dart:developer';

import 'package:bluetailor_app/service_locator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GraphqlConfig {
  static HttpLink httpLink = HttpLink(
    'https://api3.myperfectfit.co.in:5679/graphql/',
  );

  final AuthLink authLink = AuthLink(getToken: () async {
    final token = sl<SharedPreferences>().getString('token');
    if (token != null) {
      log('Bearer $token', name: 'token');
      return 'Bearer $token';
    } else {
      return '';
    }
  });

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: GraphQLCache(),
      link: authLink.concat(httpLink),
    );
  }
}
