// class DetailList{
//   DetailList({

//     this.child_id,
//     this.child_name,
//     this.child_picture
//   });

//   String? child_id;
//   String? child_name;
//   String? child_picture;
//   String? status;

//   factory DetailList.fromJson(Map<String, dynamic>? json) {
//     return DetailList(
//       child_id: json?["child_id"] == null ? null : json?['child_id'] as String,
//       child_name: json?["child_name"] == null ? null : json?['child_name'] as String,
//       child_picture: json?["child_picture"] == null ? null : json?['child_picture'] as String,
//       status: json?["status"] == null ? null : json?['status'] as String,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'child_id': child_id,
//     'child_name': child_name,
//     'child_picture': child_picture,
//     'status': status,
//   };
// }