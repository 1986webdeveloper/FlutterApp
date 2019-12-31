// To parse this JSON data, do
//
//     final pictureModel = pictureModelFromJson(jsonString);

class PictureModel {
    bool status;
    String message;
    List<PicutreModelData> data;

    PictureModel({
        this.status,
        this.message,
        this.data,
    });

    PictureModel.map(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<PicutreModelData>();
      json['data'].forEach((v) {
        data.add(new PicutreModelData.map(v));
      });
    }
  }
}

class PicutreModelData {
    int id;
    String latitude;
    String longitude;
    String created;
    String updated;
    double distance;
    List<String> image;
    List<String> imageClickUrl;

    PicutreModelData({
        this.id,
        this.latitude,
        this.longitude,
        this.created,
        this.updated,
        this.distance,
        this.image,
        this.imageClickUrl,
    });

    PicutreModelData.map(dynamic json) {
      id = json['id'];
      latitude = json['latitude'];
      longitude = json['longitude'];
      created = json['created'];
      updated = json['updated'];
      distance = json['distance'];
      image = List<String>.from(json["image"].map((x) => x));
      imageClickUrl = List<String>.from(json["image_click_url"].map((x) => x == null ? null : x));
    }
}
