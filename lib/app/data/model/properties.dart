class Properties {
  int? id;
  int? createdBy;
  String? createdDate;
  int? updatedBy;
  String? updatedDate;
  String? name;
  String? location;
  String? type;
  int? numberOfFlats;
  int? numberOfFloors;
  String? landmark;
  String? security;
  String? housekeeper;

  Properties(
      {this.id,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate,
        this.name,
        this.location,
        this.type,
        this.numberOfFlats,
        this.numberOfFloors,
        this.landmark,
        this.security,
        this.housekeeper});

  Properties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    updatedBy = json['updated_by'];
    updatedDate = json['updated_date'];
    name = json['name'];
    location = json['location'];
    type = json['type'];
    numberOfFlats = json['number_of_flats'];
    numberOfFloors = json['number_of_floors'];
    landmark = json['landmark'];
    security = json['security'];
    housekeeper = json['housekeeper'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_by'] = this.createdBy;
    data['created_date'] = this.createdDate;
    data['updated_by'] = this.updatedBy;
    data['updated_date'] = this.updatedDate;
    data['name'] = this.name;
    data['location'] = this.location;
    data['type'] = this.type;
    data['number_of_flats'] = this.numberOfFlats;
    data['number_of_floors'] = this.numberOfFloors;
    data['landmark'] = this.landmark;
    data['security'] = this.security;
    data['housekeeper'] = this.housekeeper;
    return data;
  }
}