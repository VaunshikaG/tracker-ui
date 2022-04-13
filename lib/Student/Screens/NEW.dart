import 'package:flutter/material.dart';

import '../theme.dart';

class NEW extends StatefulWidget {
  @override
  State<NEW> createState() => _NEWState();
}

class _NEWState extends State<NEW> {
  @override
  Widget build(BuildContext context) {
    return Container();
      /*Container(
      child: DataTable(
        headingRowColor: MaterialStateProperty.resolveWith(
                (states) => CustomTheme.Blue3),
        // columnSpacing: 10.0,
        // horizontalMargin: 5,
        border: TableBorder.all(),
        columns: [
          DataColumn(
            label: Text(
              'ID',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'First Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'Last Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
        rows: List.generate(
          snapshot.data.length,
              (index) => DataRow(
            cells: [
              DataCell(
                Text(
                  snapshot.data[index].id.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              DataCell(
                Text(
                  snapshot.data[index].firstName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              DataCell(
                Text(
                  'snapshot.data[index].lastName',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );*/
  }
}



/*ListTile(
                    title: Text('ID' + '    ' + 'First Name' + '    ' +
                        'Last Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text('${snapshot.data[index].id}'
                        + '    ' + '${snapshot.data[index].firstName}'
                        + '    ' + '${snapshot.data[index].lastName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              Editpg(snapshot.data[index])));
                    },
                  ),*/