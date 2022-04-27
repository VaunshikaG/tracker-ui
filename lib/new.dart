
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Employee {
  /// Creates the employee class with required details.
  Employee(this.userId, this.categoryId, this.title, this.description, this
      .totalexpense);

  /// Id of an employee.
  final String userId;
  final String categoryId;

  /// Name of an employee.
  final String title;

  /// Designation of an employee.
  final String description;

  /// Salary of an employee.
  final String totalexpense;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell(columnName: 'categoryId', value: e.categoryId),
              DataGridCell(columnName: 'title', value: e.title),
              DataGridCell(
                  columnName: 'description', value: e.description),
              DataGridCell(
                  columnName: 'totalexpense', value: e.totalexpense),
            ],
          ),
        ).toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}
