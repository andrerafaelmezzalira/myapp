class Student {
  String name;
  int id;

  Student(this.name, this.id);

  Student.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'];

  Map<String, dynamic> toJson() => {'name': name, 'id': id};
}
