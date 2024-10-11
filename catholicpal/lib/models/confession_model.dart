class LifeStageCategory {
  final String name;
  final List<ExaminationArea> areas;

  LifeStageCategory({required this.name, required this.areas});

  factory LifeStageCategory.fromJson(Map<String, dynamic> json) {
    return LifeStageCategory(
      name: json['name'],
      areas: (json['areas'] as List)
          .map((area) => ExaminationArea.fromJson(area))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'areas': areas.map((area) => area.toJson()).toList(),
    };
  }
}

class ExaminationArea {
  final String name;
  final List<Checkpoint> checkpoints;

  ExaminationArea({required this.name, required this.checkpoints});

  factory ExaminationArea.fromJson(Map<String, dynamic> json) {
    return ExaminationArea(
      name: json['name'],
      checkpoints: (json['checkpoints'] as List)
          .map((checkpoint) => Checkpoint.fromJson(checkpoint))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'checkpoints': checkpoints.map((checkpoint) => checkpoint.toJson()).toList(),
    };
  }
}

class Checkpoint {
  final String question;
  bool isChecked;

  Checkpoint({required this.question, this.isChecked = false});

  factory Checkpoint.fromJson(Map<String, dynamic> json) {
    return Checkpoint(
      question: json['question'],
      isChecked: json['isChecked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'isChecked': isChecked,
    };
  }
}