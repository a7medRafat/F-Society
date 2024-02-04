class AppStrings{
  String passwordPattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  String passwordReturn = '''
        Password must be at least 8 characters,
        include an uppercase letter, number and symbol.
        ''';

  String emailPattern = r'\w+@\w+\.\w+';
  String emailReturn = 'Invalid E-mail Address format';

  String newUser = 'https://i.pinimg.com/736x/01/4b/32/014b32b806bace5c59cfee1c4e2b466c.jpg';

  String newBio = 'write ur bio ..';
  String profileSuccessUpdate = 'profile updated successfully';
  String profileImageSuccessUpdate = 'profile Image updated successfully';
  String successStory = 'story added successfully';
  String successComment = 'comment added successfully';
  String successSaved = 'post saved successfully';
  String deletePost = 'post deleted successfully';
  String addPost = 'your post has been added successfully';
}