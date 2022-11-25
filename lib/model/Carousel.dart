import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

final dataList = [
  "https://firebasestorage.googleapis.com/v0/b/home-cleaning-service-app.appspot.com/o/image_1.PNG?alt=media&token=f96c4d4b-e6e3-4fbe-abe1-d811b4c19867",
  "https://firebasestorage.googleapis.com/v0/b/home-cleaning-service-app.appspot.com/o/image_2.PNG?alt=media&token=c1b1afde-86b7-4f50-82a3-a1d80e4eb32c",
  "https://firebasestorage.googleapis.com/v0/b/home-cleaning-service-app.appspot.com/o/image_3.PNG?alt=media&token=5f8406ab-654e-4d8c-b634-68a8ed358f55",
  "https://firebasestorage.googleapis.com/v0/b/home-cleaning-service-app.appspot.com/o/image_4.PNG?alt=media&token=52a4973a-ecdc-4cf7-98d8-9d909e03b7b8",
];


// class Banners extends Equatable{
//   final String image;
//   const Banners(String json, {required this.image})

  
// Map<String, Object> toJson() {
//     return {
//       'image': image,
//     };
//   }

//   @override
//   String toString() {
//     return 'Banners { image: $image}';
//   }

//   static Banners fromJson(Map<String, Object> json) {
//     return Banners(
//       json['image'] as String, image: '',
//     );
//   }

//   static Banners fromSnapshot(DocumentSnapshot snap) {
//     return Banners(
//       snap['image'],
//     );
//   }

//   Map<String, Object> toDocument() {
//     return {
//       'image': image,
//     };
//   }
// }


// @override
// List<Object?> get props => [image];

// static Banners fromSnapshot(DocumentSnapshot snap){
//   Banners banner = Banners(image: snap['image']);
//   return banner
// }

// abstract class BaseBanners {
//   Stream<List<Banners>> getAll
// }