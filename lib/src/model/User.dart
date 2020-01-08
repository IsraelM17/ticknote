class User{

  String name;
  String email;
  String photoUrl;

  User({
    this.name,
    this.email,
    this.photoUrl
  });

  factory User.fromJson(Map<String, dynamic> user){
    return User(
      email: user['email'],
      name: user['name'],
      photoUrl: user['photoUrl']
    );
  }

}