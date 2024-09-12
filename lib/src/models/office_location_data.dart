class LocationResponse {
  List<Locations>? locations;

  LocationResponse({this.locations});

  LocationResponse.fromJson(Map<String, dynamic> json) {
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(new Locations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.locations != null) {
      data['locations'] = this.locations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Locations {
  String? area;
  String? geo;
  String? location;
  List<String>? officeType;
  String? address;
  String? phone;
  Geometry? geometry;
  String? email;
  List<Websites>? websites;
  String? id;

  Locations(
      {this.area,
        this.geo,
        this.location,
        this.officeType,
        this.address,
        this.phone,
        this.geometry,
        this.email,
        this.websites,
        this.id});

  Locations.fromJson(Map<String, dynamic> json) {
    area = json['area'];
    geo = json['geo'];
    location = json['location'];
    officeType = json['officeType'].cast<String>();
    address = json['address'];
    phone = json['phone'];
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    email = json['email'];
    if (json['websites'] != null) {
      websites = <Websites>[];
      json['websites'].forEach((v) {
        websites!.add(new Websites.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area'] = this.area;
    data['geo'] = this.geo;
    data['location'] = this.location;
    data['officeType'] = this.officeType;
    data['address'] = this.address;
    data['phone'] = this.phone;
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    data['email'] = this.email;
    if (this.websites != null) {
      data['websites'] = this.websites!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class Geometry {
  double? lat;
  double? lng;

  Geometry({this.lat, this.lng});

  Geometry.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Websites {
  String? name;
  String? url;

  Websites({this.name, this.url});

  Websites.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
