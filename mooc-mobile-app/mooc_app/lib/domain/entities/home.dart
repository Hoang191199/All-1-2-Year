import 'package:mooc_app/domain/entities/category.dart';
import 'package:mooc_app/domain/entities/collection.dart';
import 'package:mooc_app/domain/entities/slide_show.dart';

class Home {
  Home({
    this.slide_show,
    this.collections,
    // this.menu,
  });

  List<SlideShow>? slide_show;
  List<Collection>? collections;
  // List<Category>? menu;

  factory Home.fromJson(Map<String, dynamic>? json) {
    return Home(
      slide_show: json?["slide_show"] == null ? null : List<SlideShow>.from(json?["slide_show"].map((x) => SlideShow.fromJson(x))),
      collections: json?["collections"] == null ? null : List<Collection>.from(json?["collections"].map((x) => Collection.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'slide_show': slide_show,
    'collections': collections,
  };
}
