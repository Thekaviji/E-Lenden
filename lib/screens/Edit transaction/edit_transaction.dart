import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../model/transaction_model.dart';
import '../../provider/transaction_provider.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class EditTransaction extends StatefulWidget {
  final TransactionModel transaction;

  const EditTransaction({Key? key, required this.transaction}) : super(key: key);

  @override
  _EditTransactionState createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  final List<String> _paymentModes = ['Cash', 'Online', 'Card', 'Cheque', 'Other'];
  String? _selectedPaymentMode;
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;
  late TextEditingController _transactionDateController;
  late TextEditingController _transactionTimeController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current transaction details
    _amountController = TextEditingController(text: widget.transaction.amount.toString());
    _descriptionController = TextEditingController(text: widget.transaction.description);
    _transactionDateController = TextEditingController(text: widget.transaction.transactionDate);
    _transactionTimeController = TextEditingController(text: widget.transaction.transactionTime);
    _selectedPaymentMode = widget.transaction.paymentMode;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _transactionDateController.dispose();
    _transactionTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Edit Transaction', style: TextStyle(color: Colors.white)),
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
                  backgroundColor: AppConstants.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: _handleSubmit,
                child: const Text(
                  'Update',
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
        _transactionDateController.text = picked.toIso8601String().split('T').first;
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

  void _handleSubmit() {
    if (_amountController.text.isEmpty || _selectedPaymentMode == null) {
      _showSnackbar(
        context: context,
        title: 'Error',
        message: 'Please fill all required fields',
        contentType: ContentType.warning,
      );
      return;
    }

    final amount = double.tryParse(_amountController.text);
    if (amount == null) {
      _showSnackbar(
        context: context,
        title: 'Error',
        message: 'Please enter a valid amount',
        contentType: ContentType.warning,
      );
      return;
    }

    final description = _descriptionController.text;
    final paymentMode = _selectedPaymentMode!;
    final transactionDate = _transactionDateController.text;
    final transactionTime = _transactionTimeController.text;

    // Create an updated transaction
    final updatedTransaction = TransactionModel(
      id: widget.transaction.id,
      transactionType: widget.transaction.transactionType,
      amount: amount,
      description: description,
      paymentMode: paymentMode,
      transactionDate: transactionDate,
      transactionTime: transactionTime,
      netBalance: widget.transaction.netBalance,
      netCashIn: widget.transaction.netCashIn,
      netCashOut: widget.transaction.netCashOut,
    );

    // Update the transaction in the provider
    Provider.of<TransactionProvider>(context, listen: false).updateTransaction(updatedTransaction);

    _showSnackbar(
      context: context,
      title: 'Success',
      message: 'Transaction updated successfully!',
      contentType: ContentType.success,
    );

    Navigator.of(context).pop(updatedTransaction); // Return the updated transaction
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
