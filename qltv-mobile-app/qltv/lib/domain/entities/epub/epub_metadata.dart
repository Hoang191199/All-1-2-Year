import 'package:qltv/domain/entities/epub/epub_metadata_contributor.dart';
import 'package:qltv/domain/entities/epub/epub_metadata_creator.dart';
import 'package:qltv/domain/entities/epub/epub_metadata_date.dart';
import 'package:qltv/domain/entities/epub/epub_metadata_identifier.dart';
import 'package:qltv/domain/entities/epub/epub_metadata_meta.dart';

class EpubMetadata {
  EpubMetadata({
    this.titles,
    this.creators,
    this.subjects,
    this.description,
    this.publishers,
    this.contributors,
    this.dates,
    this.types,
    this.formats,
    this.identifiers,
    this.sources,
    this.languages,
    this.relations,
    this.coverages,
    this.rights,
    this.metaItems,
  });

  List<String>? titles;
  List<EpubMetadataCreator>? creators;
  List<String>? subjects;
  String? description;
  List<String>? publishers;
  List<EpubMetadataContributor>? contributors;
  List<EpubMetadataDate>? dates;
  List<String>? types;
  List<String>? formats;
  List<EpubMetadataIdentifier>? identifiers;
  List<String>? sources;
  List<String>? languages;
  List<String>? relations;
  List<String>? coverages;
  List<String>? rights;
  List<EpubMetadataMeta>? metaItems;
}