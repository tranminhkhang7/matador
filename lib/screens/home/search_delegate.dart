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
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return const SizedBox();
  }

  @override
  void showResults(BuildContext context) {
    Navigator.of(context).popAndPushNamed(
      RoutesHandler.ACCOUNT,
      arguments: query,
    );
    super.showResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchProvider = context.watch<SearchItemsProvider>();
    Future<List<BookItem>> result = searchProvider.search(context, query);
    return FutureBuilder(
      future: result,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: snapshot.data!.length >= 10 ? 10 : snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.book),
                title: Text(snapshot.data![index].title),
                onTap: () {},
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
