import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  UserProductItem(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {

    void onEditHandler() {

    }

    void onDeleteHandler() {

    }

    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: onEditHandler,
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDeleteHandler,
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
