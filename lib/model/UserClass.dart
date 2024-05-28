class UserClass {
   String username;
   String password;

  UserClass({
    required this.username,
    required this.password,
  });

  get getUsername => this.username;

 set setUsername( Username) => this.username = Username;

  get getPassword => this.password;

 set setPassword( password) => this.password = password;
 
}
