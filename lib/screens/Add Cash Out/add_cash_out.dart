import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../model/transaction_model.dart';
import '../../provider/transaction_provider.dart';
import 'package:intl/intl.dart'; // Import for formatting date and time

class AddCashOut extends StatefulWidget {
  const AddCashOut({super.key});

  @override
  State<AddCashOut> createState() => _AddCashOutState();
}

class _AddCashOutState extends State<AddCashOut> {
  final List<String> _paymentModes = ['Cash', 'Online', 'Card', 'Cheque', 'Other'];
  String? _selectedPaymentMode;
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _transactionDateController = TextEditingController();
  final _transactionTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the initial date and time to the current date and time
    final now = DateTime.now();
    _transactionDateController.text = DateFormat('yyyy-MM-dd').format(now);
    _transactionTimeController.text = DateFormat('HH:mm').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Add Cash Out Entry',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(
                  label: Text('Amount'),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  label: Text('Remark / Description'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedPaymentMode,
                decoration: const InputDecoration(
                  label: Text('Payment Mode'),
                  border: OutlineInputBorder(),
                ),
                items: _paymentModes.map((String mode) {
                  return DropdownMenuItem<String>(
                    value: mode,
                    child: Text(mode),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMode = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a payment mode';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _transactionDateController,
                decoration: InputDecoration(
                  label: const Text('Transaction Date'),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _transactionTimeController,
                decoration: InputDecoration(
                  label: const Text('Transaction Time'),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: () => _selectTime(context),
                  ),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  if (_amountController.text.isEmpty || _selectedPaymentMode == null) {
                    _showSnackbar(
                      context: context,
                      title: 'Error',
                      message: 'Please fill all required fields',
                      contentType: ContentType.warning,
                    );
                    return;
                  }

                  final amount = double.parse(_amountController.text);
                  final description = _descriptionController.text;
                  final paymentMode = _selectedPaymentMode!;
                  final transactionDate = _transactionDateController.text;
                  final transactionTime = _transactionTimeController.text;

                  // Create a new TransactionModel instance
                  final newTransaction = TransactionModel(
                    transactionType: 'Cash Out',
                    amount: amount,
                    netBalance: 0.0,
                    netCashIn: 0.0,
                    netCashOut: amount,
                    description: description,
                    paymentMode: paymentMode,
                    transactionDate: transactionDate,
                    transactionTime: transactionTime,
                  );

                  // Add the new transaction
                  Provider.of<TransactionProvider>(context, listen: false).addTransaction(newTransaction);

                  _showSnackbar(
                    context: context,
                    title: 'Success',
                    message: 'Transaction added successfully!',
                    contentType: ContentType.success,
                  );

                  // Navigate back after success
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _transactionDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _transactionTimeController.text = picked.format(context);
      });
    }
  }

  void _showSnackbar({
    required BuildContext context,
    required String title,
    required String message,
    required ContentType contentType,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
