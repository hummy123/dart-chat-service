import 'package:graphql/client.dart';

final _httpLink = HttpLink(
  'localhost:8080',
);

final GraphQLClient client = GraphQLClient(
  /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk
  cache: GraphQLCache(),
  link: _httpLink,
);
