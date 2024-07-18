// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  Map<String, InternshipsMeta>? internshipsMeta;
  List<int>? internshipIds;

  SearchModel({
    this.internshipsMeta,
    this.internshipIds,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    internshipsMeta: Map.from(json["internships_meta"]!).map((k, v) => MapEntry<String, InternshipsMeta>(k, InternshipsMeta.fromJson(v))),
    internshipIds: json["internship_ids"] == null ? [] : List<int>.from(json["internship_ids"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "internships_meta": Map.from(internshipsMeta!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "internship_ids": internshipIds == null ? [] : List<dynamic>.from(internshipIds!.map((x) => x)),
  };
}

class InternshipsMeta {
  int? id;
  String? title;
  EmploymentType? employmentType;
  ApplicationStatusMessage? applicationStatusMessage;
  dynamic jobTitle;
  bool? workFromHome;
  Segment? segment;
  dynamic segmentLabelValue;
  dynamic internshipTypeLabelValue;
  List<Segment>? jobSegments;
  String? companyName;
  String? companyUrl;
  bool? isPremium;
  bool? isPremiumInternship;
  String? employerName;
  CompanyLogo? companyLogo;
  InternshipsMetaType? type;
  String? url;
  int? isInternchallenge;
  bool? isExternal;
  bool? isActive;
  DateTime? expiresAt;
  String? closedAt;
  String? profileName;
  bool? partTime;
  StartDate? startDate;
  Duration? duration;
  Stipend? stipend;
  dynamic salary;
  dynamic jobExperience;
  String? experience;
  String? postedOn;
  int? postedOnDateTime;
  String? applicationDeadline;
  String? expiringIn;
  String? postedByLabel;
  PostedByLabelType? postedByLabelType;
  List<String>? locationNames;
  List<Location>? locations;
  DateTime? startDateComparisonFormat;
  DateTime? startDate1;
  DateTime? startDate2;
  bool? isPpo;
  bool? isPpoSalaryDisclosed;
  dynamic ppoSalary;
  dynamic ppoSalary2;
  PpoLabelValue? ppoLabelValue;
  bool? toShowExtraLabel;
  String? extraLabelValue;
  bool? isExtraLabelBlack;
  List<dynamic>? campaignNames;
  String? campaignName;
  bool? toShowInSearch;
  String? campaignUrl;
  dynamic campaignStartDateTime;
  dynamic campaignLaunchDateTime;
  dynamic campaignEarlyAccessStartDateTime;
  dynamic campaignEndDateTime;
  List<LabelElement>? labels;
  LabelsAppElement? labelsApp;
  List<LabelsAppElement>? labelsAppInCard;
  bool? isCovidWfhSelected;
  bool? toShowCardMessage;
  String? message;
  bool? isApplicationCappingEnabled;
  String? applicationCappingMessage;
  List<dynamic>? overrideMetaDetails;
  bool? eligibleForEasyApply;
  bool? eligibleForB2BApplyNow;
  bool? toShowB2BLabel;
  bool? isInternationalJob;
  bool? toShowCoverLetter;
  String? officeDays;

  InternshipsMeta({
    this.id,
    this.title,
    this.employmentType,
    this.applicationStatusMessage,
    this.jobTitle,
    this.workFromHome,
    this.segment,
    this.segmentLabelValue,
    this.internshipTypeLabelValue,
    this.jobSegments,
    this.companyName,
    this.companyUrl,
    this.isPremium,
    this.isPremiumInternship,
    this.employerName,
    this.companyLogo,
    this.type,
    this.url,
    this.isInternchallenge,
    this.isExternal,
    this.isActive,
    this.expiresAt,
    this.closedAt,
    this.profileName,
    this.partTime,
    this.startDate,
    this.duration,
    this.stipend,
    this.salary,
    this.jobExperience,
    this.experience,
    this.postedOn,
    this.postedOnDateTime,
    this.applicationDeadline,
    this.expiringIn,
    this.postedByLabel,
    this.postedByLabelType,
    this.locationNames,
    this.locations,
    this.startDateComparisonFormat,
    this.startDate1,
    this.startDate2,
    this.isPpo,
    this.isPpoSalaryDisclosed,
    this.ppoSalary,
    this.ppoSalary2,
    this.ppoLabelValue,
    this.toShowExtraLabel,
    this.extraLabelValue,
    this.isExtraLabelBlack,
    this.campaignNames,
    this.campaignName,
    this.toShowInSearch,
    this.campaignUrl,
    this.campaignStartDateTime,
    this.campaignLaunchDateTime,
    this.campaignEarlyAccessStartDateTime,
    this.campaignEndDateTime,
    this.labels,
    this.labelsApp,
    this.labelsAppInCard,
    this.isCovidWfhSelected,
    this.toShowCardMessage,
    this.message,
    this.isApplicationCappingEnabled,
    this.applicationCappingMessage,
    this.overrideMetaDetails,
    this.eligibleForEasyApply,
    this.eligibleForB2BApplyNow,
    this.toShowB2BLabel,
    this.isInternationalJob,
    this.toShowCoverLetter,
    this.officeDays,
  });

  factory InternshipsMeta.fromJson(Map<String, dynamic> json) => InternshipsMeta(
    id: json["id"],
    title: json["title"],
    employmentType: employmentTypeValues.map[json["employment_type"]]!,
    applicationStatusMessage: json["application_status_message"] == null ? null : ApplicationStatusMessage.fromJson(json["application_status_message"]),
    jobTitle: json["job_title"],
    workFromHome: json["work_from_home"],
    segment: segmentValues.map[json["segment"]]!,
    segmentLabelValue: json["segment_label_value"],
    internshipTypeLabelValue: json["internship_type_label_value"],
    jobSegments: json["job_segments"] == null ? [] : List<Segment>.from(json["job_segments"]!.map((x) => segmentValues.map[x]!)),
    companyName: json["company_name"],
    companyUrl: json["company_url"],
    isPremium: json["is_premium"],
    isPremiumInternship: json["is_premium_internship"],
    employerName: json["employer_name"],
    companyLogo: companyLogoValues.map[json["company_logo"]]!,
    type: internshipsMetaTypeValues.map[json["type"]]!,
    url: json["url"],
    isInternchallenge: json["is_internchallenge"],
    isExternal: json["is_external"],
    isActive: json["is_active"],
    expiresAt: json["expires_at"] == null ? null : DateTime.parse(json["expires_at"]),
    closedAt: json["closed_at"],
    profileName: json["profile_name"],
    partTime: json["part_time"],
    startDate: startDateValues.map[json["start_date"]]!,
    duration: durationValues.map[json["duration"]]!,
    stipend: json["stipend"] == null ? null : Stipend.fromJson(json["stipend"]),
    salary: json["salary"],
    jobExperience: json["job_experience"],
    experience: json["experience"],
    postedOn: json["posted_on"],
    postedOnDateTime: json["postedOnDateTime"],
    applicationDeadline: json["application_deadline"],
    expiringIn: json["expiring_in"],
    postedByLabel: json["posted_by_label"],
    postedByLabelType: postedByLabelTypeValues.map[json["posted_by_label_type"]]!,
    locationNames: json["location_names"] == null ? [] : List<String>.from(json["location_names"]!.map((x) => x)),
    locations: json["locations"] == null ? [] : List<Location>.from(json["locations"]!.map((x) => Location.fromJson(x))),
    startDateComparisonFormat: json["start_date_comparison_format"] == null ? null : DateTime.parse(json["start_date_comparison_format"]),
    startDate1: json["start_date1"] == null ? null : DateTime.parse(json["start_date1"]),
    startDate2: json["start_date2"] == null ? null : DateTime.parse(json["start_date2"]),
    isPpo: json["is_ppo"],
    isPpoSalaryDisclosed: json["is_ppo_salary_disclosed"],
    ppoSalary: json["ppo_salary"],
    ppoSalary2: json["ppo_salary2"],
    ppoLabelValue: ppoLabelValueValues.map[json["ppo_label_value"]]!,
    toShowExtraLabel: json["to_show_extra_label"],
    extraLabelValue: json["extra_label_value"],
    isExtraLabelBlack: json["is_extra_label_black"],
    campaignNames: json["campaign_names"] == null ? [] : List<dynamic>.from(json["campaign_names"]!.map((x) => x)),
    campaignName: json["campaign_name"],
    toShowInSearch: json["to_show_in_search"],
    campaignUrl: json["campaign_url"],
    campaignStartDateTime: json["campaign_start_date_time"],
    campaignLaunchDateTime: json["campaign_launch_date_time"],
    campaignEarlyAccessStartDateTime: json["campaign_early_access_start_date_time"],
    campaignEndDateTime: json["campaign_end_date_time"],
    labels: json["labels"] == null ? [] : List<LabelElement>.from(json["labels"]!.map((x) => LabelElement.fromJson(x))),
    labelsApp: labelsAppElementValues.map[json["labels_app"]]!,
    labelsAppInCard: json["labels_app_in_card"] == null ? [] : List<LabelsAppElement>.from(json["labels_app_in_card"]!.map((x) => labelsAppElementValues.map[x]!)),
    isCovidWfhSelected: json["is_covid_wfh_selected"],
    toShowCardMessage: json["to_show_card_message"],
    message: json["message"],
    isApplicationCappingEnabled: json["is_application_capping_enabled"],
    applicationCappingMessage: json["application_capping_message"],
    overrideMetaDetails: json["override_meta_details"] == null ? [] : List<dynamic>.from(json["override_meta_details"]!.map((x) => x)),
    eligibleForEasyApply: json["eligible_for_easy_apply"],
    eligibleForB2BApplyNow: json["eligible_for_b2b_apply_now"],
    toShowB2BLabel: json["to_show_b2b_label"],
    isInternationalJob: json["is_international_job"],
    toShowCoverLetter: json["to_show_cover_letter"],
    officeDays: json["office_days"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "employment_type": employmentTypeValues.reverse[employmentType],
    "application_status_message": applicationStatusMessage?.toJson(),
    "job_title": jobTitle,
    "work_from_home": workFromHome,
    "segment": segmentValues.reverse[segment],
    "segment_label_value": segmentLabelValue,
    "internship_type_label_value": internshipTypeLabelValue,
    "job_segments": jobSegments == null ? [] : List<dynamic>.from(jobSegments!.map((x) => segmentValues.reverse[x])),
    "company_name": companyName,
    "company_url": companyUrl,
    "is_premium": isPremium,
    "is_premium_internship": isPremiumInternship,
    "employer_name": employerName,
    "company_logo": companyLogoValues.reverse[companyLogo],
    "type": internshipsMetaTypeValues.reverse[type],
    "url": url,
    "is_internchallenge": isInternchallenge,
    "is_external": isExternal,
    "is_active": isActive,
    "expires_at": "${expiresAt!.year.toString().padLeft(4, '0')}-${expiresAt!.month.toString().padLeft(2, '0')}-${expiresAt!.day.toString().padLeft(2, '0')}",
    "closed_at": closedAt,
    "profile_name": profileName,
    "part_time": partTime,
    "start_date": startDateValues.reverse[startDate],
    "duration": durationValues.reverse[duration],
    "stipend": stipend?.toJson(),
    "salary": salary,
    "job_experience": jobExperience,
    "experience": experience,
    "posted_on": postedOn,
    "postedOnDateTime": postedOnDateTime,
    "application_deadline": applicationDeadline,
    "expiring_in": expiringIn,
    "posted_by_label": postedByLabel,
    "posted_by_label_type": postedByLabelTypeValues.reverse[postedByLabelType],
    "location_names": locationNames == null ? [] : List<dynamic>.from(locationNames!.map((x) => x)),
    "locations": locations == null ? [] : List<dynamic>.from(locations!.map((x) => x.toJson())),
    "start_date_comparison_format": "${startDateComparisonFormat!.year.toString().padLeft(4, '0')}-${startDateComparisonFormat!.month.toString().padLeft(2, '0')}-${startDateComparisonFormat!.day.toString().padLeft(2, '0')}",
    "start_date1": "${startDate1!.year.toString().padLeft(4, '0')}-${startDate1!.month.toString().padLeft(2, '0')}-${startDate1!.day.toString().padLeft(2, '0')}",
    "start_date2": "${startDate2!.year.toString().padLeft(4, '0')}-${startDate2!.month.toString().padLeft(2, '0')}-${startDate2!.day.toString().padLeft(2, '0')}",
    "is_ppo": isPpo,
    "is_ppo_salary_disclosed": isPpoSalaryDisclosed,
    "ppo_salary": ppoSalary,
    "ppo_salary2": ppoSalary2,
    "ppo_label_value": ppoLabelValueValues.reverse[ppoLabelValue],
    "to_show_extra_label": toShowExtraLabel,
    "extra_label_value": extraLabelValue,
    "is_extra_label_black": isExtraLabelBlack,
    "campaign_names": campaignNames == null ? [] : List<dynamic>.from(campaignNames!.map((x) => x)),
    "campaign_name": campaignName,
    "to_show_in_search": toShowInSearch,
    "campaign_url": campaignUrl,
    "campaign_start_date_time": campaignStartDateTime,
    "campaign_launch_date_time": campaignLaunchDateTime,
    "campaign_early_access_start_date_time": campaignEarlyAccessStartDateTime,
    "campaign_end_date_time": campaignEndDateTime,
    "labels": labels == null ? [] : List<dynamic>.from(labels!.map((x) => x.toJson())),
    "labels_app": labelsAppElementValues.reverse[labelsApp],
    "labels_app_in_card": labelsAppInCard == null ? [] : List<dynamic>.from(labelsAppInCard!.map((x) => labelsAppElementValues.reverse[x])),
    "is_covid_wfh_selected": isCovidWfhSelected,
    "to_show_card_message": toShowCardMessage,
    "message": message,
    "is_application_capping_enabled": isApplicationCappingEnabled,
    "application_capping_message": applicationCappingMessage,
    "override_meta_details": overrideMetaDetails == null ? [] : List<dynamic>.from(overrideMetaDetails!.map((x) => x)),
    "eligible_for_easy_apply": eligibleForEasyApply,
    "eligible_for_b2b_apply_now": eligibleForB2BApplyNow,
    "to_show_b2b_label": toShowB2BLabel,
    "is_international_job": isInternationalJob,
    "to_show_cover_letter": toShowCoverLetter,
    "office_days": officeDays,
  };
}

class ApplicationStatusMessage {
  bool? toShow;
  Message? message;
  ApplicationStatusMessageType? type;

  ApplicationStatusMessage({
    this.toShow,
    this.message,
    this.type,
  });

  factory ApplicationStatusMessage.fromJson(Map<String, dynamic> json) => ApplicationStatusMessage(
    toShow: json["to_show"],
    message: messageValues.map[json["message"]]!,
    type: applicationStatusMessageTypeValues.map[json["type"]]!,
  );

  Map<String, dynamic> toJson() => {
    "to_show": toShow,
    "message": messageValues.reverse[message],
    "type": applicationStatusMessageTypeValues.reverse[type],
  };
}

enum Message {
  THE_0_APPLICANTS,
  THE_1_APPLICANTS,
  THE_2_APPLICANTS
}

final messageValues = EnumValues({
  "0 applicants": Message.THE_0_APPLICANTS,
  "1 applicants": Message.THE_1_APPLICANTS,
  "2 applicants": Message.THE_2_APPLICANTS
});

enum ApplicationStatusMessageType {
  HIGH_APPLICATIONS
}

final applicationStatusMessageTypeValues = EnumValues({
  "high_applications": ApplicationStatusMessageType.HIGH_APPLICATIONS
});

enum CompanyLogo {
  EMPTY,
  THE_6385_F8_A1_C006_B1669724321_PNG,
  THE_7_GZRSOJ5_KO8_4424_PNG
}

final companyLogoValues = EnumValues({
  "": CompanyLogo.EMPTY,
  "6385f8a1c006b1669724321.png": CompanyLogo.THE_6385_F8_A1_C006_B1669724321_PNG,
  "7gzrsoj5ko8-4424.png": CompanyLogo.THE_7_GZRSOJ5_KO8_4424_PNG
});

enum Duration {
  THE_2_MONTHS,
  THE_3_MONTHS,
  THE_5_MONTHS
}

final durationValues = EnumValues({
  "2 Months": Duration.THE_2_MONTHS,
  "3 Months": Duration.THE_3_MONTHS,
  "5 Months": Duration.THE_5_MONTHS
});

enum EmploymentType {
  INTERNSHIP
}

final employmentTypeValues = EnumValues({
  "internship": EmploymentType.INTERNSHIP
});

enum Segment {
  EMPTY,
  INTERNSHIP_FOR_WOMEN
}

final segmentValues = EnumValues({
  "": Segment.EMPTY,
  "internship_for_women": Segment.INTERNSHIP_FOR_WOMEN
});

class LabelElement {
  List<LabelsAppElement>? labelValue;
  List<LabelsAppElement>? labelMobile;
  List<LabelsAppElement>? labelApp;
  List<LabelsAppElement>? labelsAppInCard;

  LabelElement({
    this.labelValue,
    this.labelMobile,
    this.labelApp,
    this.labelsAppInCard,
  });

  factory LabelElement.fromJson(Map<String, dynamic> json) => LabelElement(
    labelValue: json["label_value"] == null ? [] : List<LabelsAppElement>.from(json["label_value"]!.map((x) => labelsAppElementValues.map[x]!)),
    labelMobile: json["label_mobile"] == null ? [] : List<LabelsAppElement>.from(json["label_mobile"]!.map((x) => labelsAppElementValues.map[x]!)),
    labelApp: json["label_app"] == null ? [] : List<LabelsAppElement>.from(json["label_app"]!.map((x) => labelsAppElementValues.map[x]!)),
    labelsAppInCard: json["labels_app_in_card"] == null ? [] : List<LabelsAppElement>.from(json["labels_app_in_card"]!.map((x) => labelsAppElementValues.map[x]!)),
  );

  Map<String, dynamic> toJson() => {
    "label_value": labelValue == null ? [] : List<dynamic>.from(labelValue!.map((x) => labelsAppElementValues.reverse[x])),
    "label_mobile": labelMobile == null ? [] : List<dynamic>.from(labelMobile!.map((x) => labelsAppElementValues.reverse[x])),
    "label_app": labelApp == null ? [] : List<dynamic>.from(labelApp!.map((x) => labelsAppElementValues.reverse[x])),
    "labels_app_in_card": labelsAppInCard == null ? [] : List<dynamic>.from(labelsAppInCard!.map((x) => labelsAppElementValues.reverse[x])),
  };
}

enum LabelsAppElement {
  INTERNATIONAL,
  INTERNSHIP
}

final labelsAppElementValues = EnumValues({
  "International": LabelsAppElement.INTERNATIONAL,
  "Internship": LabelsAppElement.INTERNSHIP
});

class Location {
  String? string;
  String? link;
  Country? country;
  String? region;
  String? locationName;

  Location({
    this.string,
    this.link,
    this.country,
    this.region,
    this.locationName,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    string: json["string"],
    link: json["link"],
    country: countryValues.map[json["country"]]!,
    region: json["region"],
    locationName: json["locationName"],
  );

  Map<String, dynamic> toJson() => {
    "string": string,
    "link": link,
    "country": countryValues.reverse[country],
    "region": region,
    "locationName": locationName,
  };
}

enum Country {
  INDIA,
  PHILIPPINES
}

final countryValues = EnumValues({
  "India": Country.INDIA,
  "Philippines": Country.PHILIPPINES
});

enum PostedByLabelType {
  INFO,
  SUCCESS
}

final postedByLabelTypeValues = EnumValues({
  "info": PostedByLabelType.INFO,
  "success": PostedByLabelType.SUCCESS
});

enum PpoLabelValue {
  WITH_JOB_OFFER
}

final ppoLabelValueValues = EnumValues({
  "With job offer": PpoLabelValue.WITH_JOB_OFFER
});

enum StartDate {
  STARTS_IMMEDIATELY
}

final startDateValues = EnumValues({
  "Starts Immediately": StartDate.STARTS_IMMEDIATELY
});

class Stipend {
  String? salary;
  dynamic tooltip;
  int? salaryValue1;
  dynamic salaryValue2;
  SalaryType? salaryType;
  Currency? currency;
  Scale? scale;
  bool? largeStipendText;

  Stipend({
    this.salary,
    this.tooltip,
    this.salaryValue1,
    this.salaryValue2,
    this.salaryType,
    this.currency,
    this.scale,
    this.largeStipendText,
  });

  factory Stipend.fromJson(Map<String, dynamic> json) => Stipend(
    salary: json["salary"],
    tooltip: json["tooltip"],
    salaryValue1: json["salaryValue1"],
    salaryValue2: json["salaryValue2"],
    salaryType: salaryTypeValues.map[json["salaryType"]]!,
    currency: currencyValues.map[json["currency"]]!,
    scale: scaleValues.map[json["scale"]]!,
    largeStipendText: json["large_stipend_text"],
  );

  Map<String, dynamic> toJson() => {
    "salary": salary,
    "tooltip": tooltip,
    "salaryValue1": salaryValue1,
    "salaryValue2": salaryValue2,
    "salaryType": salaryTypeValues.reverse[salaryType],
    "currency": currencyValues.reverse[currency],
    "scale": scaleValues.reverse[scale],
    "large_stipend_text": largeStipendText,
  };
}

enum Currency {
  INR
}

final currencyValues = EnumValues({
  "INR ": Currency.INR
});

enum SalaryType {
  FIXED
}

final salaryTypeValues = EnumValues({
  "fixed": SalaryType.FIXED
});

enum Scale {
  PERMONTH
}

final scaleValues = EnumValues({
  "permonth": Scale.PERMONTH
});

enum InternshipsMetaType {
  REGULAR,
  VIRTUAL
}

final internshipsMetaTypeValues = EnumValues({
  "regular": InternshipsMetaType.REGULAR,
  "virtual": InternshipsMetaType.VIRTUAL
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}