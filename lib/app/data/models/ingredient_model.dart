import 'dart:convert';

class IngredientModel {
  String name;
  List<Part> parts;
  IngredientModel({
    required this.name,
    required this.parts,
  });

  IngredientModel copyWith({
    String? name,
    List<Part>? parts,
  }) {
    return IngredientModel(
      name: name ?? this.name,
      parts: parts ?? this.parts,
    );
  }


  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      name: map['name'],
      parts: List<Part>.from(map['parts']?.map((x) => Part.fromMap(x))),
    );
  }


  factory IngredientModel.fromJson(String source) => IngredientModel.fromMap(json.decode(source));

  @override
  String toString() => 'IngredientModel(name: $name, parts: $parts)';

}

class Part {
  String quantity;
  String unit;
  String type;
  Part({
    required this.quantity,
    required this.unit,
    required this.type,
  });

  Part copyWith({
    String? quantity,
    String? unit,
    String? type,
  }) {
    return Part(
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      type: type ?? this.type,
    );
  }

  factory Part.fromMap(Map<String, dynamic> map) {
    return Part(
      quantity: map['quantity'],
      unit: map['unit'],
      type: map['type'],
    );
  }

  factory Part.fromJson(String source) => Part.fromMap(json.decode(source));

  @override
  String toString() => 'Part(quantity: $quantity, unit: $unit, type: $type)';
}
