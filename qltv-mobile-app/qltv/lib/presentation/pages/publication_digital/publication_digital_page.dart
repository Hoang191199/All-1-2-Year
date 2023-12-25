import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qltv/domain/entities/bookcase.dart';
import 'package:qltv/presentation/pages/publication_digital/widgets/publication_epub.dart';

class PublicationDigitalPage extends StatelessWidget {
  const PublicationDigitalPage({
    super.key,
    required this.bookcase,
  });

  final Bookcase? bookcase;

  @override
  Widget build(BuildContext context) {
    return PublicationEpub(bookcase: bookcase);
  }
}