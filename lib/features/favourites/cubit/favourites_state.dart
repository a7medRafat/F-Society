part of 'favourites_cubit.dart';

@immutable
abstract class FavouritesState {}

class FavouritesInitial extends FavouritesState {}

class AddNotificationToFbSuccessState extends FavouritesState {}
class AddNotificationToFbErrorState extends FavouritesState {}
