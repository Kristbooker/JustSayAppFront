import 'package:flutter/material.dart';
import 'package:justsaying/service/ServiceFavorite.dart';
import 'package:justsaying/models/index.dart';

class FavoritePage extends StatefulWidget {
  final int userId;
  const FavoritePage({Key? key, required int this.userId}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // late Future<Favorites> favoriteList;
  late Favorites favorites;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    favorites = Favorites();
    isLoading = true;

    ServiceFavorite.getFavorite(widget.userId).then((favFromServer) {
      setState(() {
        favorites = favFromServer;
        isLoading = false;
      });
    });
    // print(favorites.favorites[0].post.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.favorite,
          color: Colors.white,
        ),
        title: Text('Favorites'),
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 34, 31, 35),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  listFavorite(),
                ],
              ),
      ),
    );
  }

  Widget listFavorite() {
    return Expanded(
        child: ListView.builder(
      itemCount: favorites.favorites == null ? 0 : favorites.favorites.length,
      itemBuilder: (BuildContext context, int index) {
        return rowFavorite(index);
      },
    ));
  }

  Widget rowFavorite(int index) {
    // Assuming favorites.favorites[index].post.user is valid and not null.
    var favoritePost = favorites.favorites[index].post;
    var favoriteId =
        favorites.favorites[index].id; // Assuming there is an id field.

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(favoritePost.user.proImg),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    favoritePost.user.userName,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    favoritePost.content,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.remove,
                color: Colors.red,
              ),
              onPressed: () {
                // Show confirmation dialog before deleting
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Remove fovorite'),
                      content: Text(
                          'Are you sure you want to remove this favorite?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            // Just close the dialog
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Remove',
                              style: TextStyle(color: Colors.red)),
                          onPressed: () async {
                            // Close the dialog first
                            Navigator.of(context).pop();
                            // Call the delete service and check if it's successful
                            bool deleted = await ServiceFavorite.deleteFavorite(
                                favoriteId.toInt());
                            if (deleted) {
                              setState(() {
                                // Remove the item from the list on UI
                                favorites.favorites.removeAt(index);
                                // Optionally show a snackbar that the item has been deleted
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Favorite removed successfully.")));
                              });
                            } else {
                              // Handle the case where the delete operation failed.
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Failed to removed favorite.")));
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
