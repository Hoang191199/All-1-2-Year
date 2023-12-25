class LessonType {
  static const String youtube = 'Youtube';
  static const String image = 'Image';
  static const String video = 'Video';
  static const String pdf = 'Pdf';
  static const String msOffice = 'MsOffice';
  static const String audio = 'Audio';
  static const String exam = 'Exam';
}

class PaymentMethod {
  static const String internetBanking = 'DOMESTIC';
  static const String visa = 'INTERNATIONAL';
  static const String qr = 'QR';
  static const String momo = 'momo';
}

class Feature {
  static const String featureActive = 'featureActive';
  static const String featureSaleOff = 'featureSaleOff';
  static const String featureCombo = 'featureCombo';
  static const String featureHot = 'featureHot';
}

class SnackbarType {
  static const String success = 'success';
  static const String notice = 'notice';
  static const String error = 'error';
}

class ResponseCode {
  static const int success = 0;
  static const int loginSession = 401;
  static const int notFound = 404;
}

class OnepayCallbackUrl {
  static const String redirectTest = "https://moocs.codeinet.com/verified";
}

class DataType {
  static const String typeString = 'string';
  static const String typeInt = 'int';
  static const String typeDouble = 'double';
  static const String typeBool = 'bool';
  static const String typeObject = 'object';
}

enum LessonMenuItem { documentFile }