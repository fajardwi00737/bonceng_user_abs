import 'package:meta/meta.dart';

/// Contains detailed Placemarks information.
@immutable
class Placemarks {
  /// Constructs an instance with the given values for testing. [Placemarks]
  /// instances constructed this way won't actually reflect any real information
  /// from the platform, just whatever was passed in at construction time.
  Placemarks({
    this.name,
    this.street,
    this.isoCountryCode,
    this.country,
    this.postalCode,
    this.administrativeArea,
    this.subAdministrativeArea,
    this.locality,
    this.subLocality,
    this.thoroughfare,
    this.subThoroughfare,
  });

  Placemarks._({
    this.name,
    this.street,
    this.isoCountryCode,
    this.country,
    this.postalCode,
    this.administrativeArea,
    this.subAdministrativeArea,
    this.locality,
    this.subLocality,
    this.thoroughfare,
    this.subThoroughfare,
  });

  /// The name associated with the Placemarks.
  final String? name;

  /// The street associated with the Placemarks.
  final String? street;

  /// The abbreviated country name, according to the two letter (alpha-2) [ISO standard](https://www.iso.org/iso-3166-country-codes.html).
  final String? isoCountryCode;

  /// The name of the country associated with the Placemarks.
  final String? country;

  /// The postal code associated with the Placemarks.
  final String? postalCode;

  /// The name of the state or province associated with the Placemarks.
  final String? administrativeArea;

  /// Additional administrative area information for the Placemarks.
  final String? subAdministrativeArea;

  /// The name of the city associated with the Placemarks.
  final String? locality;

  /// Additional city-level information for the Placemarks.
  final String? subLocality;

  /// The street address associated with the Placemarks.
  final String? thoroughfare;

  /// Additional street address information for the Placemarks.
  final String? subThoroughfare;

  @override
  bool operator ==(dynamic o) =>
      o is Placemarks &&
          o.administrativeArea == administrativeArea &&
          o.country == country &&
          o.isoCountryCode == isoCountryCode &&
          o.locality == locality &&
          o.name == name &&
          o.postalCode == postalCode &&
          o.street == street &&
          o.subAdministrativeArea == subAdministrativeArea &&
          o.subLocality == subLocality &&
          o.subThoroughfare == subThoroughfare &&
          o.thoroughfare == thoroughfare;

  @override
  int get hashCode =>
      administrativeArea.hashCode ^
      country.hashCode ^
      isoCountryCode.hashCode ^
      locality.hashCode ^
      name.hashCode ^
      postalCode.hashCode ^
      street.hashCode ^
      subAdministrativeArea.hashCode ^
      subLocality.hashCode ^
      subThoroughfare.hashCode ^
      thoroughfare.hashCode;

  /// Converts a list of [Map] instances to a list of [Placemarks] instances.
  static List<Placemarks> fromMaps(dynamic message) {
    if (message == null) {
      throw ArgumentError('The parameter \'message\' should not be null.');
    }

    final List<Placemarks> list = message.map<Placemarks>(fromMap).toList();
    return list;
  }

  /// Converts the supplied [Map] to an instance of the [Placemarks] class.
  static Placemarks fromMap(dynamic message) {
    if (message == null) {
      throw ArgumentError('The parameter \'message\' should not be null.');
    }

    final Map<dynamic, dynamic> PlacemarksMap = message;

    return Placemarks._(
      name: PlacemarksMap['name'] ?? '',
      street: PlacemarksMap['street'] ?? '',
      isoCountryCode: PlacemarksMap['isoCountryCode'] ?? '',
      country: PlacemarksMap['country'] ?? '',
      postalCode: PlacemarksMap['postalCode'] ?? '',
      administrativeArea: PlacemarksMap['administrativeArea'] ?? '',
      subAdministrativeArea: PlacemarksMap['subAdministrativeArea'] ?? '',
      locality: PlacemarksMap['locality'] ?? '',
      subLocality: PlacemarksMap['subLocality'] ?? '',
      thoroughfare: PlacemarksMap['thoroughfare'] ?? '',
      subThoroughfare: PlacemarksMap['subThoroughfare'] ?? '',
    );
  }

  /// Converts the [Placemarks] instance into a [Map] instance that can be
  /// serialized to JSON.
  Map<String, dynamic> toJson() => {
    'name': name,
    'street': street,
    'isoCountryCode': isoCountryCode,
    'country': country,
    'postalCode': postalCode,
    'administrativeArea': administrativeArea,
    'subAdministrativeArea': subAdministrativeArea,
    'locality': locality,
    'subLocality': subLocality,
    'thoroughfare': thoroughfare,
    'subThoroughfare': subThoroughfare,
  };

  @override
  String toString() {
    return '''
      Name: $name, 
      Street: $street, 
      ISO Country Code: $isoCountryCode, 
      Country: $country, 
      Postal code: $postalCode, 
      Administrative area: $administrativeArea, 
      Subadministrative area: $subAdministrativeArea,
      Locality: $locality,
      Sublocality: $subLocality,
      Thoroughfare: $thoroughfare,
      Subthoroughfare: $subThoroughfare''';
  }
}
