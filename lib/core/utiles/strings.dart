class AppStrings{
  String passwordPattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  String passwordReturn = '''
        Password must be at least 8 characters,
        include an uppercase letter, number and symbol.
        ''';

  String emailPattern = r'\w+@\w+\.\w+';
  String emailReturn = 'Invalid E-mail Address format';


  String nullImg1 = 'https://www.instagram.com/p/Cn7_RqpstFJ/?utm_source=ig_web_copy_link';
  String nullImg2 = 'https://www.instagram.com/p/C1FyBW3sgpL/?utm_source=ig_web_copy_link&igsh=MzRlODBiNWFlZA==';
  String newUser = 'https://img.freepik.com/free-vector/flat-design-letter-f-logo-template_23-2149355266.jpg?w=740&t=st=1704444580~exp=1704445180~hmac=d49862999e5d387297e6a6a86aa5d70f56c0b6e93f62759f9f79af83714e8488';
  String newBio = 'write ur bio ..';
  String profileSuccessUpdate = 'profile Image updated successfully';
  String successStory = 'story added successfully';
  String successComment = 'comment added successfully';
  String successSaved = 'post saved successfully';
  String deletePost = 'post deleted successfully';
}