class UserModel {
  String? disorderName;
  String? email;
  String? emotion;
  String? patientAge;
  String? patientGender;
  String? patientName;
  String? phoneNumber;
  String? sessionId;
  String? uid;


  UserModel({
    this.disorderName,
    this.email,
    this.emotion,
    this.patientAge,
    this.patientGender,
    this.patientName,
    this.phoneNumber,
    this.sessionId,
    this.uid,
  });

  // Convert UserModel to a map (for Firestore update or saving)
  Map<String, dynamic> toJson() {
    return {
      'disorderName': disorderName,
      'email': email,
      'emotion': emotion,
      'patientAge': patientAge,
      'patientGender': patientGender,
      'patientName': patientName,
      'phoneNumber': phoneNumber,
      'sessionId': sessionId,
      'uid': uid,
    };
  }

  // Create a UserModel from a map (for Firestore fetching)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      disorderName: json['disorderName'],
      email: json['email'],
      emotion: json['emotion'],
      patientAge: json['patientAge'],
      patientGender: json['patientGender'],
      patientName: json['patientName'],
      phoneNumber: json['phoneNumber'],
      sessionId: json['sessionId'],
      uid: json['uid'],
    );
  }

  // copyWith method to create a new instance with modified values
  UserModel copyWith({
    String? disorderName,
    String? email,
    String? emotion,
    String? patientAge,
    String? patientGender,
    String? patientName,
    String? phoneNumber,
    String? sessionId,
    String? uid, // New optional parameter
  }) {
    return UserModel(
      disorderName: disorderName ?? this.disorderName,
      email: email ?? this.email,
      emotion: emotion ?? this.emotion,
      patientAge: patientAge ?? this.patientAge,
      patientGender: patientGender ?? this.patientGender,
      patientName: patientName ?? this.patientName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      sessionId: sessionId ?? this.sessionId,
      uid: uid ?? this.uid, // Handling new attribute
    );
  }
}
