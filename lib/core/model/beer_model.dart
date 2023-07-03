import 'dart:convert';

import 'package:equatable/equatable.dart';

class Beer extends Equatable {
  final int id;
  final String name;
  final String tagline;
  final String firstBrewed;
  final String description;
  final String imageUrl;
  final String abv;
  final String ibu;
  final String targetFg;
  final String targetOg;
  final String ebc;
  final String srm;
  final String ph;
  final String attenuationLevel;

  const Beer({
    required this.id,
    required this.name,
    required this.tagline,
    required this.firstBrewed,
    required this.description,
    required this.imageUrl,
    required this.abv,
    required this.ibu,
    required this.targetFg,
    required this.targetOg,
    required this.ebc,
    required this.srm,
    required this.ph,
    required this.attenuationLevel,
  });

  factory Beer.fromRawJson(String str) =>
      Beer.fromJson(json.decode(str) as Map<String, dynamic>);

  factory Beer.fromJson(Map<String, dynamic> json) => Beer(
        id: json["id"] as int? ?? -1,
        name: json["name"] as String? ?? "NA",
        tagline: json["tagline"] as String? ?? "NA",
        firstBrewed: json["first_brewed"] as String? ?? "NA",
        description: json["description"] as String? ?? "NA",
        imageUrl: json["image_url"] as String? ??
            "https://via.placeholder.com/53x108",
        abv: _convertDoubleToString(json["abv"]),
        ibu: _convertDoubleToString(json["ibu"]),
        targetFg: _convertDoubleToString(json["target_fg"]),
        targetOg: _convertDoubleToString(json["target_og"]),
        ebc: _convertDoubleToString(json["ebc"]),
        srm: _convertDoubleToString(json["srm"]),
        ph: _convertDoubleToString(json["ph"]),
        attenuationLevel: _convertDoubleToString(json["attenuation_level"]),
      );
  @override
  List<Object?> get props => [
        id,
        name,
        tagline,
        firstBrewed,
        description,
        imageUrl,
        abv,
        ibu,
        targetFg,
        targetOg,
        ebc,
        srm,
        ph,
        attenuationLevel
      ];
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'tagline': tagline,
        'first_brewed': firstBrewed,
        'description': description,
        'image_url': imageUrl,
        'abv': _convertStringToDoubleOrInt(abv),
        'ibu': _convertStringToDoubleOrInt(ibu),
        'target_fg': _convertStringToDoubleOrInt(targetFg),
        'target_og': _convertStringToDoubleOrInt(targetOg),
        'ebc': _convertStringToDoubleOrInt(ebc),
        'srm': _convertStringToDoubleOrInt(srm),
        'ph': _convertStringToDoubleOrInt(ph),
        'attenuation_level': _convertStringToDoubleOrInt(attenuationLevel),
      };
}

String _convertDoubleToString(dynamic value) {
  if (value == null) return (-1).toString();
  if (value % 1 == 0) return (value as int).toString();
  if (value == value.toInt().toDouble()) {
    return (value as double).toStringAsFixed(0);
  } else {
    return (value as double).toStringAsFixed(1);
  }
}

dynamic _convertStringToDoubleOrInt(String value) {
  if (value.isEmpty) return null;
  if (value.contains('.')) {
    return double.tryParse(value) ?? 0.0;
  } else {
    return int.tryParse(value) ?? 0;
  }
}
