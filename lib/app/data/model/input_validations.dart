class InputValidation {
  static List validator({required String Digit, required String amount, required String currentBalance}) {
    if (Digit == "" || (int.tryParse(Digit) ?? 0) < 0) {
      return [
        false,
        "Validation Error!",
        "Digit cannot be empty or negative",
        false
      ];
    }

    if (amount == '' ||  amount.isEmpty) {
      return [
        false,
        "Validation Error!",
        "Amount Cannot be empty or negative",
        false
      ];
    }

    if ((double.tryParse(amount.toString().trim())??0.0) > (double.tryParse(currentBalance.toString().trim())??0.0)) {
      return [
        false,
        "Validation Error!",
        "Insufficient Fund",
        false
      ];
    }

    return [true, "Success", "Data Uploaded Success", true];
  }
}
