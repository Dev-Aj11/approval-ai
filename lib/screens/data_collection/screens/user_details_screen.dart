import 'package:approval_ai/screens/data_collection/widgets/custom_heading.dart';
import 'package:approval_ai/widgets/primary_cta.dart';
import 'package:flutter/material.dart';
import 'package:approval_ai/widgets/custom_text_field.dart';
import '../widgets/step_indicator.dart';
import '../../../widgets/custom_app_bar.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        buttons: [
          ButtonConfig(label: "Cancel", onPress: () {}),
          ButtonConfig(label: "Save & Exit", onPress: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(64.0, 72, 64, 72),
          child: Center(
            child: SizedBox(
              width: 590,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  StepIndicator(currentStep: 0),
                  SizedBox(height: 43),
                  CustomHeading(label: "Let's get started"),
                  SizedBox(height: 40.0),
                  LoanDetailsForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoanDetailsForm extends StatefulWidget {
  const LoanDetailsForm({super.key});

  @override
  State<LoanDetailsForm> createState() => _LoanDetailsFormState();
}

class _LoanDetailsFormState extends State<LoanDetailsForm> {
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
    // if (_formKey.currentState?.validate() ?? false) {
    //   // Handle next step
    // }
    Navigator.pushReplacementNamed(context, '/loandetails');
  }

  validateName(value) {
    if (value?.isEmpty ?? true) {
      return 'Please enter your name';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: 'Your full name',
            controller: _fullNameController,
            focusNode: _fullNameNode,
            validator: (value) {
              return validateName(value);
            },
          ),
          SizedBox(height: 32.0),
          CustomTextField(
            label: 'Annual Gross Income',
            controller: _grossIncomeController,
            focusNode: _grossIncomeNode,
            prefix: '\$',
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 32.0),
          CustomTextField(
            label: 'Social Security Number',
            hint: '9 digits',
            controller: _ssnController,
            focusNode: _ssnNode,
            suffixIcon: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                // Show SSN info
              },
            ),
          ),
          SizedBox(height: 32.0),
          CustomTextField(
            label: 'Property Address',
            controller: _addressController,
            focusNode: _addressNode,
          ),
          SizedBox(height: 32.0),
          CustomTextField(
            label: 'Purchase Price',
            controller: _purchasePriceController,
            focusNode: _purchasePriceNode,
            prefix: '\$',
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 32.0),
          CustomTextField(
            label: 'Loan Amount',
            controller: _loanAmtController,
            focusNode: _loanAmtNode,
            hint: 'Approximation',
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 48.0),
          PrimaryCta(label: "Next", onPressCb: () => onNextBtnPress(context)),
        ],
      ),
    );
  }
}
