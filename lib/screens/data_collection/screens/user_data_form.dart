import 'package:approval_ai/screens/data_collection/widgets/custom_heading.dart';
import 'package:approval_ai/widgets/primary_cta.dart';
import 'package:flutter/material.dart';
import 'package:approval_ai/widgets/custom_text_field.dart';

class UserDataForm extends StatefulWidget {
  final VoidCallback onComplete;
  const UserDataForm({required this.onComplete, super.key});

  @override
  State<UserDataForm> createState() => _UserDataFormState();
}

class _UserDataFormState extends State<UserDataForm> {
  // 1) Form Validation: It's used to programmatically validate all form fields at once. For example:
  // 2) The GlobalKey provides a unique identifier for the Form widget across the entire app,
  // ensuring Flutter can track and manage its state correctly.
  // 3) It helps Flutter maintain the form's state during widget rebuilds and when navigating between screen.
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _grossIncomeController = TextEditingController();
  final _ssnController = TextEditingController();
  final _addressController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _loanAmtController = TextEditingController();
  final _fullNameNode = FocusNode();
  final _grossIncomeNode = FocusNode();
  final _ssnNode = FocusNode();
  final _addressNode = FocusNode();
  final _purchasePriceNode = FocusNode();
  final _loanAmtNode = FocusNode();

  @override
  void dispose() {
    _fullNameNode.dispose();
    _grossIncomeNode.dispose();
    _ssnNode.dispose();
    _addressNode.dispose();
    _purchasePriceNode.dispose();
    _loanAmtNode.dispose();
    super.dispose();
  }

  void onNextBtnPress(context) {
    if (_formKey.currentState?.validate() == true) {
      // save to firebase and then proceed to next step
      widget.onComplete();
    }
  }

  validateName(value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter your name';
    }
    return null;
  }

  validateGrossIncome(value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter your income';
    }
    return null;
  }

  validateAddress(value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter property address';
    }
    return null;
  }

  validateSSN(value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter a valid SSN';
    }
    if (value?.toString().length != 9) {
      return 'Please enter a valid SSN';
    }
    return null;
  }

  validatePurchasePrice(value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter a purchase price';
    }
    return null;
  }

  validateLoanAmount(value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter a loan amount';
    }
    int loanAmount = int.parse(value.toString().replaceAll(',', ''));
    int purchasePrice =
        int.parse(_purchasePriceController.text.replaceAll(',', ''));
    if (loanAmount > purchasePrice) {
      return "Loan amount should be lower than purchase price ";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomHeading(label: "Let's get started"),
        SizedBox(height: 40.0),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: 'Your full name',
                controller: _fullNameController,
                focusNode: _fullNameNode,
                textOnly: true,
                validator: (value) => validateName(value),
              ),
              SizedBox(height: 32.0),
              CustomTextField(
                label: 'Annual Gross Income',
                controller: _grossIncomeController,
                focusNode: _grossIncomeNode,
                prefix: '\$',
                keyboardType: TextInputType.number,
                isMoney: true,
                validator: (value) => validateGrossIncome(value),
              ),
              SizedBox(height: 32.0),
              CustomTextField(
                label: 'Social Security Number',
                hint: '9 digits',
                digitsOnly: true,
                controller: _ssnController,
                focusNode: _ssnNode,
                validator: (value) => validateSSN(value),
              ),
              SizedBox(height: 32.0),
              CustomTextField(
                label: 'Property Address',
                controller: _addressController,
                focusNode: _addressNode,
                validator: (value) => validateAddress(value),
              ),
              SizedBox(height: 32.0),
              CustomTextField(
                label: 'Purchase Price',
                controller: _purchasePriceController,
                focusNode: _purchasePriceNode,
                isMoney: true,
                prefix: '\$',
                keyboardType: TextInputType.number,
                validator: (value) => validatePurchasePrice(value),
              ),
              SizedBox(height: 32.0),
              CustomTextField(
                label: 'Desired Loan Amount',
                controller: _loanAmtController,
                focusNode: _loanAmtNode,
                prefix: '\$',
                isMoney: true,
                keyboardType: TextInputType.number,
                validator: (value) => validateLoanAmount(value),
              ),
              SizedBox(height: 48.0),
              PrimaryCta(
                  label: "Next", onPressCb: () => onNextBtnPress(context)),
            ],
          ),
        ),
      ],
    );
  }
}
