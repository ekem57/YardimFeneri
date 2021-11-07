import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:yardimfeneri/EXTENSIONS/size_extension.dart';


class CitySearch extends SearchDelegate<String>{

  @override
  String get searchFieldLabel => "Şehir Ara";

  final List<String>? cities;
  String? result;

  CitySearch(this.cities);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Theme.of(context).primaryColor),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_rounded, color: Theme.of(context).primaryColor),
      onPressed: () {
        close(context, result!);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = cities!.where((name) {
      return name.toLowerCase().contains(query.toLowerCase());
    });

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
          child: Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            elevation: 4,
            child: ListTile(
              onTap: () {
                Navigator.pop(context,suggestions.elementAt(index));
              },
              title: Text(suggestions.elementAt(index)),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = cities!.where((name) {
      return name.toLowerCase().contains(query.toLowerCase());
    });

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
          child: Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            elevation: 4,
            child: ListTile(
              onTap: () {
                Navigator.pop(context,suggestions.elementAt(index));
              },
              title: Text(suggestions.elementAt(index),),
            ),
          ),
        );
      },
    );
  }
}



