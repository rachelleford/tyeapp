import 'package:flutter/material.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class BudgetPage extends StatefulWidget {
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  final Map<String, Map<String, TextEditingController>> _controllers = {
    'A. Housing': {
      'Mortgage or Rent': TextEditingController(),
      'Second Mortgage': TextEditingController(),
      'Property Taxes': TextEditingController(),
      'Repairs/Maintenance': TextEditingController(),
      'HOA Fees': TextEditingController(),
      'Electricity': TextEditingController(),
      'Gas': TextEditingController(),
      'Water': TextEditingController(),
      'Telephone': TextEditingController(),
      'Cable/Internet': TextEditingController(),
      'Mortgage on other homes': TextEditingController(),
      'Other': TextEditingController(),
    },
    'B. Transportation': {
      'Vehicle 1(loan)': TextEditingController(),
      'Vehicle 2(loan)': TextEditingController(),
      'Public Transportation': TextEditingController(),
      'Vehicle Insurance': TextEditingController(),
      'Fuel': TextEditingController(),
      'Maintenance': TextEditingController(),
    },
    'C. Other Debt': {
      'Credit Card #1': TextEditingController(),
      'Credit Card #2': TextEditingController(),
      'Credit Card #3': TextEditingController(),
      'Unsecured (Personal) Loan(s)': TextEditingController(),
      'Student Loan(s)': TextEditingController(),
      'Other': TextEditingController(),
    },
    'D. Personal': {
      'Entertainment': TextEditingController(),
      'Household toiletries and supplies': TextEditingController(),
      'Groceries': TextEditingController(),
      'Dining Out': TextEditingController(),
      'Medical': TextEditingController(),
      'Grooming': TextEditingController(),
      'Clothing': TextEditingController(),
      'Health club or other club fees/dues': TextEditingController(),
      'Charitable contributions': TextEditingController(),
      'Pet expenses': TextEditingController(),
      'Other': TextEditingController(),
    },
    'E. Legal': {
      'Attorney': TextEditingController(),
      'Alimony': TextEditingController(),
      'Payments on lien or judgment': TextEditingController(),
      'Child Support': TextEditingController(),
      'Other': TextEditingController(),
    },
    'F. Family (incl. Children)': {
      'Medical': TextEditingController(),
      'Clothing': TextEditingController(),
      'School supplies': TextEditingController(),
      'School tuition': TextEditingController(),
      'Organization dues': TextEditingController(),
      'Child care': TextEditingController(),
      'Toys/Games': TextEditingController(),
      'Other': TextEditingController(),
    },
    'G. Insurance': {
      'Home Insurance': TextEditingController(),
      'Health Insurance': TextEditingController(),
      'Life Insurance': TextEditingController(),
      'Other': TextEditingController(),
    },
    'H. Savings or Investments': {
      'Retirement Accounts': TextEditingController(),
      'Investments Accounts': TextEditingController(),
      'College Savings': TextEditingController(),
      'Other': TextEditingController(),
    },
    'I. Taxes': {
      'Federal': TextEditingController(),
      'State': TextEditingController(),
      'Local': TextEditingController(),
      'Other': TextEditingController(),
    },
  };

  final Set<String> _checkedItems = {};

  double _calculateTotalExpenses() {
    double total = 0.0;
    for (var section in _controllers.values) {
      for (var controller in section.values) {
        total += double.tryParse(controller.text) ?? 0.0;
      }
    }
    return total;
  }

  double _calculatePossibleReductions() {
    double total = 0.0;
    for (var section in _controllers.values) {
      for (var entry in section.entries) {
        if (_checkedItems.contains(entry.key)) {
          total += double.tryParse(entry.value.text) ?? 0.0;
        }
      }
    }
    return total;
  }

  double _calculateSectionSubtotal(
      Map<String, TextEditingController> controllers) {
    double subtotal = 0.0;
    for (var controller in controllers.values) {
      subtotal += double.tryParse(controller.text) ?? 0.0;
    }
    return subtotal;
  }

  Future<void> _saveToPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Monthly Household Budget Worksheet',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 20),
              ..._controllers.entries.map((section) {
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(section.key,
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 10),
                    ...section.value.entries.map((entry) {
                      return pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(entry.key, style: pw.TextStyle(fontSize: 13)),
                          pw.Text('\$${entry.value.text}',
                              style: pw.TextStyle(fontSize: 13)),
                          pw.Text(
                              _checkedItems.contains(entry.key) ? '✓' : ' '),
                        ],
                      );
                    }).toList(),
                    pw.SizedBox(height: 10),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Subtotal for ${section.key.split('.')[0]}',
                            style: pw.TextStyle(
                                fontSize: 13, fontWeight: pw.FontWeight.bold)),
                        pw.Text(
                            '\$${_calculateSectionSubtotal(section.value).toStringAsFixed(2)}',
                            style: pw.TextStyle(
                                fontSize: 13, fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                    pw.SizedBox(height: 20),
                  ],
                );
              }).toList(),
              pw.Text(
                'Total of Sections A-I: \$${_calculateTotalExpenses().toStringAsFixed(2)}',
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                'Possible reductions in monthly expenses: \$${_calculatePossibleReductions().toStringAsFixed(2)}',
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/budget.pdf');
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF saved to ${file.path}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Household Budget Worksheet'),
        backgroundColor: Colors.blue[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'List your monthly expenses. IMPORTANT: If you see an area in which you can reduce a monthly expense, please put a check-mark in the box to the right of the amount',
              style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
            ..._buildSections(),
            SizedBox(height: 20),
            _buildTotalRow('Total of Sections A-I', _calculateTotalExpenses()),
            _buildTotalRow(
                'Possible reductions', _calculatePossibleReductions()),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveToPDF,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                backgroundColor: Colors.blue[700],
              ),
              child: Text(
                'Save to Profile',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSections() {
    return _controllers.entries.map((section) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.key,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ..._buildFormRows(section.value),
          SizedBox(height: 10),
          _buildSubtotalRow(
              section.key, _calculateSectionSubtotal(section.value)),
          SizedBox(height: 20),
        ],
      );
    }).toList();
  }

  List<Widget> _buildFormRows(Map<String, TextEditingController> controllers) {
    return controllers.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Text(entry.key, style: TextStyle(fontSize: 13)),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 30,
                child: TextField(
                  controller: entry.value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    isDense: true,
                    prefixText: '\$ ',
                  ),
                  style: TextStyle(fontSize: 13),
                  keyboardType: TextInputType.number,
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ),
            SizedBox(width: 4),
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: _checkedItems.contains(entry.key),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _checkedItems.add(entry.key);
                    } else {
                      _checkedItems.remove(entry.key);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildTotalRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtotalRow(String sectionKey, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Subtotal for ${sectionKey.split('.')[0]}',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
