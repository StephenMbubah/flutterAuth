class UserModel{
  String name;
  String email;
  String bio;
  String profilePic;
  String createdAt;
  String phoneNumber;
  String uid;
  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.bio,
    required this.phoneNumber,
    required this.createdAt,
    required this.profilePic

});
  // from map
  factory UserModel.froMap(Map<String,dynamic> map){
    return UserModel(
        name: map['name'] ??'' ,
        email:  map['email'] ??'',
        uid:  map['uid'] ??'',
        bio:  map['bio'] ??'',
        phoneNumber:  map['phoneNumber'] ??'',
        createdAt:  map['createdAt'] ??'',
        profilePic:  map['profilePics'] ??'',
    );
  }
  // to map
  Map<String, dynamic> toMap(){
    return{
      "name": name,
      "email": email,
      "uid": uid,
      "bio": bio,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "createdAt" : createdAt,
    };
  }
}