import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:calculator_admin/pages/home/home.dart';
import 'package:calculator_admin/utils/utils.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              flex: 1, 
              child: TextFormField(
                key: const Key('search_text_field'),
                decoration: InputDecoration(
                  labelText: 'Search ID',
                  labelStyle: const TextStyle(color: Colors.green),
                  filled: true,
                  contentPadding: const EdgeInsets.only(left: 20.0, top: 15, right: 20, bottom: 15),
                  fillColor: const Color.fromARGB(30, 37, 193, 102),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: SelectedInputBorderWithShadow(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none
                  ),
                  suffixIcon: searchButton(context, state)
                ),
                onChanged: (value) => context.read<HomeBloc>().add(SearchTextFieldChanged(value))
              )
            ),
            Flexible(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: PopupMenuButton(
                  icon: Icon(
                    FontAwesomeIcons.filter,
                    color: Colors.green,
                    shadows: <Shadow>[
                      Shadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 3,
                        offset: const Offset(0, 1.5)
                      )
                    ]
                  ),
                  onSelected: (value) {
                    context.read<HomeBloc>().add(UsersLoaded(filter: value));
                  },
                  itemBuilder: (BuildContext context) {
                    final filters = ["newest", "oldest", "newlyUpdated", "oldestUpdated"];
                    return filters.map((String value) {
                      return PopupMenuItem<String>(
                        value: value,
                        child: Text(value.replaceAll("U", " u"))
                      );
                    }).toList();
                  }
                )
              )
            )
          ]
        );
      }
    );
  }
}

Widget searchButton(BuildContext context, HomeState state) {
  return IconButton(
    icon: Icon(
      FontAwesomeIcons.magnifyingGlass,
      color: const Color(0xFF25C166),
      shadows: <Shadow>[
        Shadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 3,
          offset: const Offset(0, 1.5)
        )
      ]
    ),
    onPressed: () {
      context.read<HomeBloc>().add(UsersLoaded(searchQuery: state.searchQuery.value));
    }
  );
}
