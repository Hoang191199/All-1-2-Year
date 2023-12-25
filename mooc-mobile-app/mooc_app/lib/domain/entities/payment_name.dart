class PaymentName {
PaymentName({
  this.name,
  this.value,
  this.resourceNotFound,
  this.searchedLocation,
});

String? name;
String? value;
bool? resourceNotFound;
String? searchedLocation;

factory PaymentName.fromJson(Map<String, dynamic>? json) {
return PaymentName(
  name: json?["name"] == null ? null : json?['name'] as String,
  value: json?["value"] == null ? null : json?['value'] as String,
  resourceNotFound: json?["resourceNotFound"] == null ? null : json?['resourceNotFound'] as bool,
  searchedLocation: json?["searchedLocation"] == null ? null : json?['searchedLocation'] as String,
);
}

Map<String, dynamic> toJson() => {
  "name": name,
  "value": value,
  "resourceNotFound": resourceNotFound,
  "searchedLocation": searchedLocation
};
}