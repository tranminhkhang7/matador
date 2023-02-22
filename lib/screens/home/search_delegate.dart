import 'package:flutter/material.dart';
import 'package:grocery_app/constants/routes_constraints.dart';
import 'package:grocery_app/models/book_item.dart';
import 'package:grocery_app/providers/search_list_provider.dart';
import 'package:grocery_app/widgets/loader.dart';
import 'package:provider/provider.dart';

class SearchBookDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.close,
        ),
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: colorScheme.brightness == Brightness.dark
            ? Colors.grey[900]
            : Colors.white,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  void showResults(BuildContext context) {
    super.showResults(context);

    Navigator.of(context).popAndPushNamed(
      RoutesHandler.SEARCH_ALL,
      arguments: query,
    );
    // close(context, query);
  }

  void navigateToBookDetailScreen(BookItem b, BuildContext context) {
    Navigator.pushNamed(
      context,
      RoutesHandler.SINGLE_PRODUCT,
      arguments: b,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    late Future<List<BookItem>> result;
    if (query.isNotEmpty || query != '') {
      final searchProvider = context.watch<SearchItemsProvider>();
      result = searchProvider.search(context, query);
    }

    return query.isEmpty || query == ''
        ? SizedBox(
            child: const Text('Search for ur result'),
          )
        : FutureBuilder(
            future: result,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount:
                      snapshot.data!.length >= 10 ? 10 : snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: ClipRRect(
                          child: Image.network(
                            snapshot.data![index].imageLink,
                            height: 100,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(2),
                          ),
                        ),
                        title: Text(snapshot.data![index].title),
                        onTap: () => navigateToBookDetailScreen(
                          snapshot.data![index],
                          context,
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              } else {
                return const SizedBox();
              }
            },
          );
  }
}
