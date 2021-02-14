import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzgram/search/bloc/search_bloc.dart';
import 'package:fuzzgram/search/model/search_template.dart';

class SearchWidget extends StatelessWidget {

  SearchWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, TemplateSearchState>(
      builder: (context, activeTab) {
        return Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30)
                .copyWith(bottom: 20),
            decoration: BoxDecoration(
                boxShadow: [
                  const BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 0.5)
                ],
                borderRadius: BorderRadius.circular(25),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.search,
                    color: Colors.blueGrey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  new Flexible(
                    child: new TextField(
                        decoration: InputDecoration(
                          hintText: 'Search templates',
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.grey,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        print("Searching value: " + value);
                      },
                  ),
                  ),
                ],
              ),
            ),
          );
      },
    );
  }
}
