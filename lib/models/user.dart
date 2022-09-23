// ignore_for_file: public_member_api_docs, sort_constructors_first

class User {
  int? id;
  String? username;
  String? password;
  String? role;
  bool? isDelete;
  String? userProjects;
  String? notes;
  String? userVotes;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.role,
    required this.isDelete,
    required this.userProjects,
    required this.notes,
    required this.userVotes,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    username = json['Username'];
    password = json['Password'];
    role = json['Role'];
    isDelete = json['IsDelete'];
    userProjects = json['UserProjects'];
    notes = json['Notes'];
    userVotes = json['UserVotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Username'] = username;
    data['Password'] = password;
    data['Role'] = role;
    data['IsDelete'] = isDelete;
    data['UserProjects'] = userProjects;
    data['Notes'] = notes;
    data['UserVotes'] = userVotes;
    return data;
  }

  User copyWith({
    int? id,
    String? username,
    String? password,
    String? role,
    bool? isDelete,
    String? userProjects,
    String? notes,
    String? userVotes,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
      isDelete: isDelete ?? this.isDelete,
      userProjects: userProjects ?? this.userProjects,
      notes: notes ?? this.notes,
      userVotes: userVotes ?? this.userVotes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'password': password,
      'role': role,
      'isDelete': isDelete,
      'userProjects': userProjects,
      'notes': notes,
      'userVotes': userVotes,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      isDelete: map['isDelete'] != null ? map['isDelete'] as bool : null,
      userProjects:
          map['userProjects'] != null ? map['userProjects'] as String : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      userVotes: map['userVotes'] != null ? map['userVotes'] as String : null,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, password: $password, role: $role, isDelete: $isDelete, userProjects: $userProjects, notes: $notes, userVotes: $userVotes)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.password == password &&
        other.role == role &&
        other.isDelete == isDelete &&
        other.userProjects == userProjects &&
        other.notes == notes &&
        other.userVotes == userVotes;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        password.hashCode ^
        role.hashCode ^
        isDelete.hashCode ^
        userProjects.hashCode ^
        notes.hashCode ^
        userVotes.hashCode;
  }
}
