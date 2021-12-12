import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yardimfeneri/SERVICE/helpful_service.dart';

AppBar buildAppBar(BuildContext context) {
  final icon = Icons.exit_to_app;
  final _helpfulService = Provider.of<HelpfulService>(context, listen: true);
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        icon: Icon(icon),
        color: Colors.black,
        iconSize:40,
        onPressed: () {
          _helpfulService.signOut();
        },
      ),
    ],
  );
}