/// FileName template_model
///
/// @Author ke_zhang
/// @Date 2022/11/23 23:17
///
/// @Description TODO
class TemplateModel {
  int? id;
  String? templateGroup;
  Content? content;
  String? createdBy;
  String? createdTime;
  String? updatedBy;
  String? updatedTime;

  TemplateModel(
      {this.id,
      this.templateGroup,
      this.content,
      this.createdBy,
      this.createdTime,
      this.updatedBy,
      this.updatedTime});

  TemplateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    templateGroup = json['templateGroup'];
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
    createdBy = json['createdBy'];
    createdTime = json['createdTime'];
    updatedBy = json['updatedBy'];
    updatedTime = json['updatedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['templateGroup'] = this.templateGroup;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    data['createdBy'] = this.createdBy;
    data['createdTime'] = this.createdTime;
    data['updatedBy'] = this.updatedBy;
    data['updatedTime'] = this.updatedTime;
    return data;
  }
}

class Content {
  String? title;
  String? description;
  int? templateId;
  List<QueContentList>? queContentList;

  Content({this.title, this.description, this.templateId, this.queContentList});

  Content.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    templateId = json['templateId'];
    if (json['queContentList'] != null) {
      queContentList = <QueContentList>[];
      json['queContentList'].forEach((v) {
        queContentList!.add(new QueContentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['templateId'] = this.templateId;
    if (this.queContentList != null) {
      data['queContentList'] =
          this.queContentList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QueContentList {
  String? title;
  String? description;
  int? type;
  int? isRequire;
  Null? identifyRule;
  List<QueOptions>? queOptions;
  Null? surveyId;
  Null? templateId;
  int? queOrder;

  QueContentList(
      {this.title,
      this.description,
      this.type,
      this.isRequire,
      this.identifyRule,
      this.queOptions,
      this.surveyId,
      this.templateId,
      this.queOrder});

  QueContentList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    type = json['type'];
    isRequire = json['isRequire'];
    identifyRule = json['identifyRule'];
    if (json['queOptions'] != null) {
      queOptions = <QueOptions>[];
      json['queOptions'].forEach((v) {
        queOptions!.add(new QueOptions.fromJson(v));
      });
    }
    surveyId = json['surveyId'];
    templateId = json['templateId'];
    queOrder = json['queOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    data['isRequire'] = this.isRequire;
    data['identifyRule'] = this.identifyRule;
    if (this.queOptions != null) {
      data['queOptions'] = this.queOptions!.map((v) => v.toJson()).toList();
    }
    data['surveyId'] = this.surveyId;
    data['templateId'] = this.templateId;
    data['queOrder'] = this.queOrder;
    return data;
  }
}

class QueOptions {
  int? order;
  String? answer;

  QueOptions({this.order, this.answer});

  QueOptions.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order'] = this.order;
    data['answer'] = this.answer;
    return data;
  }
}
