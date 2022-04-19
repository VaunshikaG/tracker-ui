import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tracker_ui/Common/Prefs.dart';
import 'package:tracker_ui/Common/theme.dart';

class Homepg extends StatefulWidget {
  @override
  State<Homepg> createState() => _HomepgState();
}

class _HomepgState extends State<Homepg> {
  @override
  Widget build(BuildContext context) {
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
          actions: [
            IconButton(
              alignment: Alignment(0, 0),
              icon: Icon(Icons.logout),
              splashColor: Colors.white,
              onPressed: () {
                Prefs.instance.removeAll();
                print("user logged out");
                Navigator.popAndPushNamed(context, '/myapp');
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // user id
                const SizedBox(
                  height: 25,
                  child: Text(
                    'User Id :  ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),

                //  category id
                const SizedBox(
                  height: 25,
                  child: Text(
                    'Category Id :  ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),

                const SizedBox(height: 10),

                //  title
                const SizedBox(
                  height: 25,
                  child: Text(
                    'Category Name',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    minLines: 1,
                    maxLines: 5,
                    autofocus: true,
                    style: const TextStyle(fontSize: 17),
                    keyboardType: TextInputType.text,
                    controller: titleController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.red,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //  description
                const SizedBox(
                  height: 25,
                  child: Text(
                    'Category Description',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    // minLines: 1,
                    maxLines: 7,
                    style: const TextStyle(fontSize: 17),
                    controller: descController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.red,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.only(top: 10),
          child: FloatingActionButton(
            child: const Text(
              "+ Add",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => addcategories(),
            elevation: 10,
            backgroundColor: CustomTheme.Grey2,
            splashColor: CustomTheme.Blue3,
            hoverColor: CustomTheme.Blue3,
          ),
        ),
      ),
      onWillPop: () => SystemNavigator.pop(),
    );
  }

  //  add categories
  final formKeys = GlobalKey<FormState>();

  TextEditingController titleController = new TextEditingController();
  TextEditingController descController = new TextEditingController();

  Widget addcategories() {
    showDialog(
      context: context,
      builder: (BuildContext buildContext) => SimpleDialog(
        // insetPadding: const EdgeInsets.symmetric(horizontal: 0),
        contentPadding: const EdgeInsets.fromLTRB(20, 0, 10, 20),
        titleTextStyle: const TextStyle(
          fontSize: 16,
          color: CustomTheme.Grey1,
          fontWeight: FontWeight.bold,
        ),
        title: const Text(
          'Add Category',
          // maxLines: 3,
          textAlign: TextAlign.start,
        ),
        children: [
          Form(
            key: formKeys,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // user id
                const SizedBox(
                  height: 25,
                  child: Text(
                    'User Id :  ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),

                //  category id
                const SizedBox(
                  height: 25,
                  child: Text(
                    'Category Id :  ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),

                const SizedBox(height: 10),

                //  title
                const SizedBox(
                  height: 25,
                  child: Text(
                    'Category Name',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    minLines: 1,
                    maxLines: 5,
                    autofocus: true,
                    style: const TextStyle(fontSize: 17),
                    keyboardType: TextInputType.text,
                    controller: titleController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.red,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //  description
                const SizedBox(
                  height: 25,
                  child: Text(
                    'Category Description',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    // minLines: 1,
                    maxLines: 7,
                    style: const TextStyle(fontSize: 17),
                    controller: descController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: Colors.red,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    ),
                  ),
                ),

                //  submit
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: FlatButton(
                        color: CustomTheme.Grey2,
                        splashColor: CustomTheme.Blue3,
                        hoverColor: CustomTheme.Blue3,
                        onPressed: () => Navigator.of(buildContext).pop(false),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: FlatButton(
                        color: CustomTheme.Grey2,
                        splashColor: CustomTheme.Blue3,
                        hoverColor: CustomTheme.Blue3,
                        onPressed: () {
                          setState(() {
                            if (formKeys.currentState.validate()) {
                              formKeys.currentState.save();
                              Navigator.of(buildContext).pop(false);
                            }
                          });
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
