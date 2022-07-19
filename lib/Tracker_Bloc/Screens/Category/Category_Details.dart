import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../BLoC/Category/Category_BloC.dart';
import '../../Common/theme.dart';
import '../../Models/Category/Model2.dart';
import 'Category.dart';

class CategoryDetails extends StatefulWidget {
  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  showDeleteConfirmation() {
    AlertDialog alert = AlertDialog(
      title: const Text(
        'Delete category?',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        'Are you sure you want to delete this category?',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          color: CustomTheme.Coral2,
          child: const Text(
            'Delete',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    final catbloc = Provider.of<CategoryBloC>(context, listen: false);

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomTheme.Grey2,
          title: const Text(
            'CATEGORY',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Category())),
          ),
        ),
        body: StreamBuilder(
          stream: catbloc.catList,
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Text('There was an error : ${snapshot.error}');
            List<Model2> users = snapshot.data;

            return ListView.separated(
              itemCount: users?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                Model2 _user = users[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: FittedBox(
                        child: Text(
                          'Title',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: StreamBuilder<String>(
                        stream: catbloc.title,
                        builder: (context, AsyncSnapshot<String>
                        snapshot) => TextFormField(
                          //  to set entered text
                          initialValue: _user.title,
                          onChanged: catbloc.changedTitle,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            errorText: snapshot.error,
                            errorStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                              ),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                              ),
                            ),
                            errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            focusedErrorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        'ID :   ${_user.categoryId}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        'Title :    ${_user.title}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        'Description :    ${_user.description}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        'Total Expense :    ${_user.totalexpense}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => Divider(),
            );
          },
        ),
        floatingActionButton: Container(
          padding: const EdgeInsets.only(top: 10),
          child: FloatingActionButton.extended(
            label: const Text(
              "Update",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              catbloc.update();
            },
            elevation: 10,
            backgroundColor: CustomTheme.Grey2,
            splashColor: CustomTheme.Blue3,
            hoverColor: CustomTheme.Blue3,
          ),
        ),
      ),
      onWillPop: () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
        return Category();
      })),
    );
  }
}
