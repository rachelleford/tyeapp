import 'package:flutter/material.dart';

class Spendinglimits extends StatefulWidget {
  @override
  _SpendingLimitsPageState createState() => _SpendingLimitsPageState();
}

class _SpendingLimitsPageState extends State<Spendinglimits> {
  final Map<String, TextEditingController> _controllers = {
    'A. Housing': TextEditingController(),
    'B. Transportation': TextEditingController(),
    'C. Other Debt': TextEditingController(),
    'D. Personal': TextEditingController(),
    'E. Legal': TextEditingController(),
    'F. Family': TextEditingController(),
    'G. Insurance': TextEditingController(),
    'H. Savings or Investments': TextEditingController(),
    'I. Taxes': TextEditingController(),
  };

  final TextEditingController _income1Controller = TextEditingController();
  final TextEditingController _income2Controller = TextEditingController();
  final TextEditingController _income3Controller = TextEditingController();
  final TextEditingController _income4Controller = TextEditingController();

  double get totalExpenses {
    return _controllers.values.fold(
        0, (sum, controller) => sum + (double.tryParse(controller.text) ?? 0));
  }

  double get totalIncome {
    return [_income1Controller, _income2Controller, _income3Controller].fold(
        0, (sum, controller) => sum + (double.tryParse(controller.text) ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spending Limits'),
        backgroundColor: Colors.blue[700],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Income',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            _buildIncomeRow('Salary/Wages', _income1Controller),
            _buildIncomeRow('Freelance/Side Hustle', _income2Controller),
            _buildIncomeRow('Rental Income', _income3Controller),
            _buildIncomeRow('Other', _income4Controller),
            _buildTotalRow('Total Income', totalIncome),
            SizedBox(height: 20),
            Text('Expenses',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ..._controllers.entries
                .map((entry) => _buildSummaryRow(entry.key, entry.value)),
            Divider(),
            _buildTotalRow('Total of Sections A-I', totalExpenses),
            SizedBox(height: 6),
            _buildTotalRow(
                'Income minus Expenses', totalIncome - totalExpenses),
            SizedBox(height: 6),
            Center(
              child: ElevatedButton(
                onPressed: _saveToProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: Text(
                  'Save to Profile',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(label, style: TextStyle(fontSize: 12))),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 30,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  prefixText: '\$ ',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                ),
                style: TextStyle(fontSize: 12),
                keyboardType: TextInputType.number,
                onChanged: (_) => setState(() {}),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeRow(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(label, style: TextStyle(fontSize: 12))),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 30,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  prefixText: '\$ ',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                ),
                style: TextStyle(fontSize: 12),
                keyboardType: TextInputType.number,
                onChanged: (_) => setState(() {}),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text('\$${amount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _saveToProfile() {
    // TODO: Implement the logic to save the budget summary to the user's profile
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Budget summary saved to profile')),
    );
  }
}
