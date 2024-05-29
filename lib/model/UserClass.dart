class UserClass {
  String? name;
   String usermail;
   String password;
   int? phone;
   String? address;




  UserClass({
    required this.usermail,
    required this.password,
  });

  Map<String,dynamic> toMap(){
    return(
      {
        "name":name,
        "email":usermail,
        "password":password,
        "phone":phone,
        "address":address
      }
    );
  }

  get getusermail => this.usermail;

 set setusermail( usermail) => this.usermail = usermail;

  get getPassword => this.password;

 set setPassword( password) => this.password = password;
 
}
