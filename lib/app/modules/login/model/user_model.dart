class UserModel {
  String? id;
  String? arn;
  String? status;
  String? userPoolId;
  String? username;
  String? email;
  bool? emailVerified;
  String? phone;
  bool? phoneVerified;
  int? unionid;
  int? openid;
  String? identities;
  String? nickname;
  List<String>? registerSource;
  String? photo;
  String? password;
  String? oauth;
  late final String token;
  String? tokenExpiredAt;
  int? loginsCount;
  String? lastLogin;
  String? lastIP;
  String? signedUp;
  bool? blocked;
  String? device;
  String? browser;
  String? company;
  String? name;
  String? givenName;
  String? familyName;
  String? middleName;
  String? profile;
  String? preferredUsername;
  String? website;
  String? gender;
  String? birthdate;
  String? zoneinfo;
  String? locale;
  String? address;
  String? formatted;
  String? streetAddress;
  String? locality;
  String? region;
  int? postalCode;
  String? city;
  String? province;
  String? country;
  String? createdAt;
  String? updatedAt;
  String? roles;
  var groups;
  String? departments;
  String? authorizedResources;
  int? externalId;
  int? secondaryUserIds;
  String? customData;
  String? lastLoginApp;
  bool? deleted;

  UserModel(
      {this.id,
      this.arn,
      this.status,
      this.userPoolId,
      this.username,
      this.email,
      this.emailVerified,
      this.phone,
      this.phoneVerified,
      this.unionid,
      this.openid,
      this.identities,
      this.nickname,
      this.registerSource,
      this.photo,
      this.password,
      this.oauth,
      required this.token,
      this.tokenExpiredAt,
      this.loginsCount,
      this.lastLogin,
      this.lastIP,
      this.signedUp,
      this.blocked,
      this.device,
      this.browser,
      this.company,
      this.name,
      this.givenName,
      this.familyName,
      this.middleName,
      this.profile,
      this.preferredUsername,
      this.website,
      this.gender,
      this.birthdate,
      this.zoneinfo,
      this.locale,
      this.address,
      this.formatted,
      this.streetAddress,
      this.locality,
      this.region,
      this.postalCode,
      this.city,
      this.province,
      this.country,
      this.createdAt,
      this.updatedAt,
      this.roles,
      this.groups,
      this.departments,
      this.authorizedResources,
      this.externalId,
      this.secondaryUserIds,
      this.customData,
      this.lastLoginApp,
      this.deleted});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arn = json['arn'];
    status = json['status'];
    userPoolId = json['userPoolId'];
    username = json['username'];
    email = json['email'];
    emailVerified = json['emailVerified'];
    phone = json['phone'];
    phoneVerified = json['phoneVerified'];
    unionid = json['unionid'];
    openid = json['openid'];
    identities = json['identities'];
    nickname = json['nickname'];
    registerSource = json['registerSource'].cast<String>();
    photo = json['photo'];
    password = json['password'];
    oauth = json['oauth'];
    token = json['token'];
    tokenExpiredAt = json['tokenExpiredAt'];
    loginsCount = json['loginsCount'];
    lastLogin = json['lastLogin'];
    lastIP = json['lastIP'];
    signedUp = json['signedUp'];
    blocked = json['blocked'];
    device = json['device'];
    browser = json['browser'];
    company = json['company'];
    name = json['name'];
    givenName = json['givenName'];
    familyName = json['familyName'];
    middleName = json['middleName'];
    profile = json['profile'];
    preferredUsername = json['preferredUsername'];
    website = json['website'];
    gender = json['gender'];
    birthdate = json['birthdate'];
    zoneinfo = json['zoneinfo'];
    locale = json['locale'];
    address = json['address'];
    formatted = json['formatted'];
    streetAddress = json['streetAddress'];
    locality = json['locality'];
    region = json['region'];
    postalCode = json['postalCode'];
    city = json['city'];
    province = json['province'];
    country = json['country'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    roles = json['roles'];
    groups = json['groups'];
    departments = json['departments'];
    authorizedResources = json['authorizedResources'];
    externalId = json['externalId'];
    secondaryUserIds = json['secondaryUserIds'];
    customData = json['customData'];
    lastLoginApp = json['lastLoginApp'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arn'] = this.arn;
    data['status'] = this.status;
    data['userPoolId'] = this.userPoolId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['emailVerified'] = this.emailVerified;
    data['phone'] = this.phone;
    data['phoneVerified'] = this.phoneVerified;
    data['unionid'] = this.unionid;
    data['openid'] = this.openid;
    data['identities'] = this.identities;
    data['nickname'] = this.nickname;
    data['registerSource'] = this.registerSource;
    data['photo'] = this.photo;
    data['password'] = this.password;
    data['oauth'] = this.oauth;
    data['token'] = this.token;
    data['tokenExpiredAt'] = this.tokenExpiredAt;
    data['loginsCount'] = this.loginsCount;
    data['lastLogin'] = this.lastLogin;
    data['lastIP'] = this.lastIP;
    data['signedUp'] = this.signedUp;
    data['blocked'] = this.blocked;
    data['device'] = this.device;
    data['browser'] = this.browser;
    data['company'] = this.company;
    data['name'] = this.name;
    data['givenName'] = this.givenName;
    data['familyName'] = this.familyName;
    data['middleName'] = this.middleName;
    data['profile'] = this.profile;
    data['preferredUsername'] = this.preferredUsername;
    data['website'] = this.website;
    data['gender'] = this.gender;
    data['birthdate'] = this.birthdate;
    data['zoneinfo'] = this.zoneinfo;
    data['locale'] = this.locale;
    data['address'] = this.address;
    data['formatted'] = this.formatted;
    data['streetAddress'] = this.streetAddress;
    data['locality'] = this.locality;
    data['region'] = this.region;
    data['postalCode'] = this.postalCode;
    data['city'] = this.city;
    data['province'] = this.province;
    data['country'] = this.country;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['roles'] = this.roles;
    data['groups'] = this.groups;
    data['departments'] = this.departments;
    data['authorizedResources'] = this.authorizedResources;
    data['externalId'] = this.externalId;
    data['secondaryUserIds'] = this.secondaryUserIds;
    data['customData'] = this.customData;
    data['lastLoginApp'] = this.lastLoginApp;
    data['deleted'] = this.deleted;
    return data;
  }
}
