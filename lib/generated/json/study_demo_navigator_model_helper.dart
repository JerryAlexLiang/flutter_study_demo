import 'package:flutter_study_demo/model/study_demo_navigator_model.dart';

studyDemoNavigatorModelFromJson(StudyDemoNavigatorModel data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'].toString() as int;
	}
	if (json['image'] != null) {
		data.image = json['image'].toString();
	}
	return data;
}

Map<String, dynamic> studyDemoNavigatorModelToJson(StudyDemoNavigatorModel entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['id'] = entity.id;
	data['image'] = entity.image;
	return data;
}