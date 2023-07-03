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
