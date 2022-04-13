import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/StudentModel.dart';
import '../theme.dart';
import 'Delete.dart';
import 'Home.dart';
import 'Update.dart';

final String app_url = "http://10.0.0.12:8080/";

class Details extends StatefulWidget {
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var stud = List<StudentModel>.generate(200, (index) => null);

  Future<List<StudentModel>> getDetails() async {
    final response = await http.get(Uri.parse(app_url + 'getstudent'));

    var jsonData = jsonDecode(response.body);
    List<StudentModel> newstud = [];

    try{
      if (response.statusCode == 200 || response.statusCode == 400) {
        for (var s in jsonData) {
          StudentModel studentModel = new StudentModel();
          studentModel.id = s["id"];
          studentModel.firstName = s["firstName"];
          studentModel.lastName = s["lastName"];
          newstud.add(studentModel);
        }
        return newstud;
      }
    } catch(e) {
      print(e);
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          backgroundColor: CustomTheme.Blue1,
          centerTitle: true,
          title: Text(
            'Student Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FutureBuilder(
          future: getDetails(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData) {
              return SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'ID',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'First Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Last Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),

                      Divider(
                        height: 20,
                        indent: 5,
                        endIndent: 5,
                        thickness: 0.7,
                        color: Colors.black,
                      ),
                      SizedBox(height: 10),

                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Editpg(snapshot.data[index])));
                              },
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        snapshot.data[index].id.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data[index].firstName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data[index].lastName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 18,
                                    indent: 15,
                                    endIndent: 15,
                                    thickness: 0.7,
                                    color: Colors.grey.shade400,
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              );
            }
            else if(snapshot.data == null || snapshot.hasError) {
              return Container(
                child: Center(
                  child: Icon(CupertinoIcons.exclamationmark_circle_fill),
                ),
              );
            }
          },
        ),
      ),
      onWillPop: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => Home())),
    );
  }
}


class Editpg extends StatelessWidget {
  StudentModel student;
  Editpg(this.student);

  deleteStud(StudentModel studentModel) async {
    final request = http.Request(
        "DELETE",
        Uri.parse(
          app_url + 'deletestudent',
        ));
    request.headers.addAll(<String, String>{
      "Content-type": "application/json",
    });
    request.body = jsonEncode(studentModel);
    final response = await request.send();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Details()));
            },
          ),
          backgroundColor: CustomTheme.Blue1,
          centerTitle: true,
          title: Text(
            student.firstName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Update(student))),
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'First Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Last Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Divider(
                height: 10,
                indent: 10,
                endIndent: 10,
                thickness: 0.7,
                color: Colors.black,
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    student.firstName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: 16,
                    ),
                  ),
                  Text(
                    student.lastName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            deleteStud(student);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Delete()));
          },
          child: Icon(Icons.delete),
          backgroundColor: Colors.pink,
        ),
      ),
      onWillPop: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => Details())),
    );
  }
}
