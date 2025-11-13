import 'package:flutter/material.dart';

class StudentRow extends StatelessWidget {
  final String name;
  final String dni;
  final String status;
  final ValueChanged<String> onStatusChanged;

  const StudentRow({
    Key? key,
    required this.name,
    required this.dni,
    required this.status,
    required this.onStatusChanged,
  }) : super(key: key);

  static const options = ['PRESENT', 'ABSENT', 'AUSENT'];

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text('DNI: $dni'),
      trailing: DropdownButton<String>(
        value: status,
        items: options
            .map((o) => DropdownMenuItem<String>(
                  value: o,
                  child: Text(o),
                ))
            .toList(),
        onChanged: (v) {
          if (v != null) onStatusChanged(v);
        },
      ),
    );
  }
}