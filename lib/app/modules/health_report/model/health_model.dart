class HealthModel {
  final String? isTest48;
  final String? isContactOverseasPersonnel;
  final String? isInSchool;
  final String? isQuarantine;
  final String? supplementaryNotes;
  final String? isHealthy;
  final String? isSymptom10;
  final String? createdTime;
  final String? isInformedByTeacher;
  final num? id;
  final String? isAccinated;
  final String? updatedTime;
  final String? address;
  final String? isAsymptomaticInfection;
  final String? healthId;
  final String? isSuspectedCovid19;
  final String? userId;
  final String? isContactSickPeople;
  final String? isTransitHignrisk;
  final String? isConfirmedCovid19;
  final String? isStayHignrisk;
  final String? isGoAbroad;
  final String? position;
  final String? isContactHighriskPersonnel;
  final String? isResponsibleForAuthenticity;
  final String? reportTime;

  HealthModel({
    this.isTest48,
    this.isContactOverseasPersonnel,
    this.isInSchool,
    this.isQuarantine,
    this.supplementaryNotes,
    this.isHealthy,
    this.isSymptom10,
    this.createdTime,
    this.isInformedByTeacher,
    this.id,
    this.isAccinated,
    this.updatedTime,
    this.address,
    this.isAsymptomaticInfection,
    this.healthId,
    this.isSuspectedCovid19,
    this.userId,
    this.isContactSickPeople,
    this.isTransitHignrisk,
    this.isConfirmedCovid19,
    this.isStayHignrisk,
    this.isGoAbroad,
    this.position,
    this.isContactHighriskPersonnel,
    this.isResponsibleForAuthenticity,
    this.reportTime,
  });

  factory HealthModel.fromJson(Map<String, dynamic> json) {
    return HealthModel(
      isTest48: json['isTest48'],
      isContactOverseasPersonnel: json['isContactOverseasPersonnel'],
      isInSchool: json['isInSchool'],
      isQuarantine: json['isQuarantine'],
      supplementaryNotes: json['supplementaryNotes'],
      isHealthy: json['isHealthy'],
      isSymptom10: json['isSymptom10'],
      createdTime: json['createdTime'],
      isInformedByTeacher: json['isInformedByTeacher'],
      id: json['id'],
      isAccinated: json['isAccinated'],
      updatedTime: json['updatedTime'],
      address: json['address'],
      isAsymptomaticInfection: json['isAsymptomaticInfection'],
      healthId: json['healthId'],
      isSuspectedCovid19: json['isSuspectedCovid19'],
      userId: json['userId'],
      isContactSickPeople: json['isContactSickPeople'],
      isTransitHignrisk: json['isTransitHignrisk'],
      isConfirmedCovid19: json['isConfirmedCovid19'],
      isStayHignrisk: json['isStayHignrisk'],
      isGoAbroad: json['isGoAbroad'],
      position: json['position'],
      isContactHighriskPersonnel: json['isContactHighriskPersonnel'],
      isResponsibleForAuthenticity: json['isResponsibleForAuthenticity'],
      reportTime: json['reportTime'],
    );
  }

  Map<String, dynamic> toJson() => {
        'isTest48': isTest48,
        'isContactOverseasPersonnel': isContactOverseasPersonnel,
        'isInSchool': isInSchool,
        'isQuarantine': isQuarantine,
        'supplementaryNotes': supplementaryNotes,
        'isHealthy': isHealthy,
        'isSymptom10': isSymptom10,
        'createdTime': createdTime,
        'isInformedByTeacher': isInformedByTeacher,
        'id': id,
        'isAccinated': isAccinated,
        'updatedTime': updatedTime,
        'address': address,
        'isAsymptomaticInfection': isAsymptomaticInfection,
        'healthId': healthId,
        'isSuspectedCovid19': isSuspectedCovid19,
        'userId': userId,
        'isContactSickPeople': isContactSickPeople,
        'isTransitHignrisk': isTransitHignrisk,
        'isConfirmedCovid19': isConfirmedCovid19,
        'isStayHignrisk': isStayHignrisk,
        'isGoAbroad': isGoAbroad,
        'position': position,
        'isContactHighriskPersonnel': isContactHighriskPersonnel,
        'isResponsibleForAuthenticity': isResponsibleForAuthenticity,
        'reportTime': reportTime,
      };
}
