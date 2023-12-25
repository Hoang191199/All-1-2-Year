class UserRole {
  static const String owner = 'owner';
  static const String teacher = 'teacher';
  static const String student = 'student';
}

class DataType {
  static const String typeString = 'string';
  static const String typeInt = 'int';
  static const String typeDouble = 'double';
  static const String typeBool = 'bool';
  static const String typeObject = 'object';
}

class SnackbarType {
  static const String success = 'success';
  static const String notice = 'notice';
  static const String error = 'error';
}

class TemplateType {
  static const String carousel = 'carousel';
  static const String focus = 'focus';
}

class BookcaseType {
  static const String digital_publications = 'digital_publications';
  static const String publications = 'publications';
  static const String document = 'document';
}

class BookcaseViewType {
  static const String grid = 'grid';
  static const String list = 'list';
}

class BookcaseSortType {
  static const String title = 'title';
  static const String authors = 'authors';
  static const String created_at = 'created_at';
  static const String last_seen = 'last_seen';
}

class BookcaseFilterType {
  static const int notRead = 0;
  static const int reading = 1;
  static const int readCompleted = 2;
}

class MediaType {
  static const String application_xhtml_xml = 'application/xhtml+xml';
  static const String application_x_dtbook_xml = 'application/x-dtbook+xml';
  static const String application_x_dtbncx_xml = 'application/x-dtbncx+xml';
  static const String text_x_oeb1_document = 'text/x-oeb1-document';
  static const String application_xml = 'application/xml';
  static const String text_css = 'text/css';
  static const String text_x_oeb1_css = 'text/x-oeb1-css';
  static const String image_gif = 'image/gif';
  static const String image_jpeg = 'image/jpeg';
  static const String image_png = 'image/png';
  static const String image_svg_xml = 'image/svg+xml';
  static const String font_truetype = 'font/truetype';
  static const String font_opentype = 'font/opentype';
  static const String application_vnd_ms_opentype = 'application/vnd.ms-opentype';
}

class FileFormat {
  static const String application_epub_zip = 'application/epub+zip';
}

class HandleAudio {
  static const String playing = 'playing';
  static const String pause = 'pause';
  static const String stop = 'stop';
}