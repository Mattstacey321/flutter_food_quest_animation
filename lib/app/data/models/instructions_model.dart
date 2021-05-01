import 'dart:convert';

class InstructionModel {
  String name;
  List<String> steps;
  InstructionModel({
    required this.name,
    required this.steps,
  });
  

  InstructionModel copyWith({
    String? name,
    List<String>? steps,
  }) {
    return InstructionModel(
      name: name ?? this.name,
      steps: steps ?? this.steps,
    );
  }


  factory InstructionModel.fromMap(Map<String, dynamic> map) {
    return InstructionModel(
      name: map['name'],
      steps: List<String>.from(map['steps']),
    );
  }


  factory InstructionModel.fromJson(String source) => InstructionModel.fromMap(json.decode(source));

  @override
  String toString() => 'InstructionModel(name: $name, steps: $steps)';
}
