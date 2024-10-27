import 'dart:developer';

import 'package:bluetailor_app/core/api/graphql_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ApiClient {
  GraphqlConfig graphqlConfig = GraphqlConfig();

  Future<QueryResult<Object?>> queryData(
      {required String query, required Map<String, dynamic> variable}) async {
    GraphQLClient client = graphqlConfig.clientToQuery();
    QueryResult result = await client.query(
      QueryOptions(document: gql(query), variables: variable),
    );
    log(result.data.toString());
    return result;
  }

  Future<QueryResult<Object?>> mutateData(
      {required String query, required Map<String, dynamic> variable}) async {
    GraphQLClient client = graphqlConfig.clientToQuery();
    QueryResult result = await client.mutate(
      MutationOptions(document: gql(query), variables: variable),
    );
    log(result.data.toString());
    return result;
  }
}
