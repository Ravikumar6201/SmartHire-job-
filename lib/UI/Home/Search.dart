// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemSearchDelegate extends SearchDelegate<String> {
  final List<String> items = [
    'Edelman Financial Engines',
    'Nasdaq Corporate Solutions',
    'The ICR Group',
    'Georgeson',
    'MWWPR (MWW Group)',
    'The Investor ',
    'Finsbury',
    'CCI',
    'CCG Investor Relations',
    'LRW (Lippincott)',
    'Brunswick Group',
    'Weber Shandwick',
    'Huntsworth',
    'Sard Verbinnen & Co.',
    'KCSA Strategic',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search field
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, ''); // Close the search
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = items
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Image.asset('assets/images/Search.png'),
              ),
              Text(
                results[index],
                style: GoogleFonts.manrope(fontSize: 16),
              ),
            ],
          ),
          onTap: () {
            close(
                context, results[index]); // Return the selected item and close
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = items
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Image.asset('assets/images/Search.png'),
              ),
              Text(
                suggestions[index],
                style: GoogleFonts.manrope(fontSize: 16),
              ),
            ],
          ),
          onTap: () {
            close(
              context,
              suggestions[index],
            ); // Return immediately when clicked
          },
        );
      },
    );
  }
}
