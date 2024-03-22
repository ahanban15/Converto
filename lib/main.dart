import 'package:flutter/material.dart';

void main() {
  runApp(UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Converto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UnitConverterHomePage(),
    );
  }
}

class UnitConverterHomePage extends StatefulWidget {
  @override
  _UnitConverterHomePageState createState() => _UnitConverterHomePageState();
}

class _UnitConverterHomePageState extends State<UnitConverterHomePage> {
  double _inputValue = 0.0;
  double _outputValue = 0.0;

  String _selectedInputUnit = '';
  String _selectedOutputUnit = '';

  List<String> _lengthUnits = ['Meter', 'Centimeter', 'Kilometer'];
  List<String> _weightUnits = ['Gram', 'Kilogram'];
  List<String> _temperatureUnits = ['Celsius', 'Fahrenheit'];

  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Converto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: ['Length', 'Weight', 'Temperature']
                  .map((category) => DropdownMenuItem(
                        child: Text(category),
                        value: category,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                  if (_selectedCategory == 'Length') {
                    _selectedInputUnit = _lengthUnits[0];
                    _selectedOutputUnit = _lengthUnits[1];
                  } else if (_selectedCategory == 'Weight') {
                    _selectedInputUnit = _weightUnits[0];
                    _selectedOutputUnit = _weightUnits[1];
                  } else if (_selectedCategory == 'Temperature') {
                    _selectedInputUnit = _temperatureUnits[0];
                    _selectedOutputUnit = _temperatureUnits[1];
                  }
                  _convert();
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Input Value'),
              onChanged: (value) {
                setState(() {
                  _inputValue = double.tryParse(value) ?? 0.0;
                  _convert();
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedInputUnit,
                    items: _getUnitsList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedInputUnit = value!;
                        _convert();
                      });
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedOutputUnit,
                    items: _getUnitsList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedOutputUnit = value!;
                        _convert();
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Output Value: $_outputValue'),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _getUnitsList() {
    List<String> unitsList = [];
    if (_selectedCategory == 'Length') {
      unitsList = _lengthUnits;
    } else if (_selectedCategory == 'Weight') {
      unitsList = _weightUnits;
    } else if (_selectedCategory == 'Temperature') {
      unitsList = _temperatureUnits;
    }
    return unitsList
        .map((unit) => DropdownMenuItem(
              child: Text(unit),
              value: unit,
            ))
        .toList();
  }

  void _convert() {
    if (_selectedCategory == 'Length') {
      _outputValue = _convertLength();
    } else if (_selectedCategory == 'Weight') {
      _outputValue = _convertWeight();
    } else if (_selectedCategory == 'Temperature') {
      _outputValue = _convertTemperature();
    }
  }

  double _convertLength() {
    double inputValue = _inputValue;
    if (_selectedInputUnit == 'Centimeter') {
      inputValue /= 100;
    } else if (_selectedInputUnit == 'Kilometer') {
      inputValue *= 1000;
    }

    double outputValue = inputValue;
    if (_selectedOutputUnit == 'Centimeter') {
      outputValue *= 100;
    } else if (_selectedOutputUnit == 'Kilometer') {
      outputValue /= 1000;
    }

    return outputValue;
  }

  double _convertWeight() {
    double inputValue = _inputValue;
    if (_selectedInputUnit == 'Kilogram') {
      inputValue *= 1000;
    }

    double outputValue = inputValue;
    if (_selectedOutputUnit == 'Kilogram') {
      outputValue /= 1000;
    }

    return outputValue;
  }

  double _convertTemperature() {
    double inputValue = _inputValue;
    if (_selectedInputUnit == 'Fahrenheit') {
      inputValue = (inputValue - 32) * 5 / 9;
    }

    double outputValue = inputValue;
    if (_selectedOutputUnit == 'Fahrenheit') {
      outputValue = (outputValue * 9 / 5) + 32;
    }

    return outputValue;
  }
}
