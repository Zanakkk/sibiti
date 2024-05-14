// ignore_for_file: file_names

class Province {
  final String provinceCode;
  final String name;

  Province({required this.provinceCode, required this.name});

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      provinceCode: json['code'],
      name: json['name'],
    );
  }
}

class Regency {
  final String regencyCode;
  final String name;

  Regency({required this.regencyCode, required this.name});

  factory Regency.fromJson(Map<String, dynamic> json) {
    return Regency(
      regencyCode: json['code'],
      name: json['name'],
    );
  }
}

class University {
  final String universityCode;
  final String name;

  University({required this.universityCode, required this.name});

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      universityCode: json['university_code'],
      name: json['name'],
    );
  }
}

class Major {
  final String majorCode;
  final String name;

  Major({required this.majorCode, required this.name});

  factory Major.fromJson(Map<String, dynamic> json) {
    return Major(
      majorCode: json['major_code'],
      name: json['name'],
    );
  }
}

class School {
  final String schoolCode;
  final String name;

  School({required this.schoolCode, required this.name});

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      schoolCode: json['school_code'],
      name: json['name'],
    );
  }
}
