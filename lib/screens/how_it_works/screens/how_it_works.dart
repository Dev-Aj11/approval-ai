import 'package:flutter/material.dart';
import 'package:approval_ai/screens/how_it_works/screens/widgets/custom_dialog.dart';

class HowItWorksScreen extends StatefulWidget {
  const HowItWorksScreen({super.key});

  @override
  State<HowItWorksScreen> createState() => _HowItWorksScreenState();
}

class _HowItWorksScreenState extends State<HowItWorksScreen> {
  int _currentStep = 0;
  _buildDismissButton(context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(
        Icons.close,
        color: Colors.grey[600],
      ),
    );
  }

  _onPressNext() {
    if (_currentStep == 3) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        _currentStep = _currentStep + 1;
      });
    }
  }

  _buildHowItWorksContent() {
    if (_currentStep == 0) {
      return CustomDialog(
          header: "Step 1: Contact Lenders",
          content:
              "📞 Our AI agent swings into action, reaching out to a variety of lenders from local gems to big-name banks.",
          imgPath: "assets/img/contact_lenders.png",
          onPressNext: _onPressNext,
          btnText: "Next");
    } else if (_currentStep == 1) {
      return CustomDialog(
        header: "Step 2: Receive Estimates",
        content:
            "⏳ In 3-5 business days, lenders send loan estimates with key details like rates, amounts, and fees. \n(We'll make it easy to understand, promise!)",
        imgPath: "assets/img/receive_estimates.png",
        onPressNext: _onPressNext,
        btnText: "Next",
      );
    } else if (_currentStep == 2) {
      return CustomDialog(
          header: "Step 3: Negotiate for Better Deals",
          content:
              "💰 Our AI gets down to business, comparing all the loan offers side-by-side and negotiates with lenders to save you thousands on your loans.",
          imgPath: "assets/img/negotiate_better_deals.png",
          onPressNext: _onPressNext,
          btnText: "Next");
    } else if (_currentStep == 3) {
      return CustomDialog(
        header: "Step 4: Rank the Best Deals",
        content:
            "🏆 When the dust settles, we'll handpick the top 3 mortgage deals that make the most sense for you.",
        imgPath: "assets/img/rank_deals.png",
        onPressNext: _onPressNext,
        btnText: "Done",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shadowColor: Colors.grey[400],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 600,
          maxHeight: 1200,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16,
            top: 16.0,
            bottom: 40,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildDismissButton(context),
              _buildHowItWorksContent(),
            ],
          ),
        ),
      ),
    );
  }
}
