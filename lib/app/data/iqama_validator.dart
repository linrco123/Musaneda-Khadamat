class IqamaValidator {
  /// The method that checks if a string contains a valid Saudi/ID number.
  ///
  /// Takes a string [iqamaStr] and
  /// Returns [bool] true if it contains a valid iqama/id number, false otherwise.
  static bool validate(String iqamaStr) => _validateIqamaNo(iqamaStr);

  /// The method that returns the length of each block of a valid Iqama/ID.
  ///
  /// Takes [iqama] and [position] and returns a valid integer which is its length
  static int _findBlockLength(String iqama, int position) {
    int tempLength = (int.parse(iqama.substring(position, position + 1)) * 2);
    int retVal = "$tempLength".length;
    return retVal;
  }

  /// The method that evaluates a block of Iqama/ID
  static int _evaluateBlock(int blockValue, String iqama, int position) {
    int trimValue = int.parse(iqama.substring(position, position + 1));
    if (blockValue == 1) {
      return trimValue * 2;
    } else {
      if (blockValue == 2) {
        int sum = (trimValue * 2);
        int firstPlace = int.parse("$sum".substring(0, 1));
        int secondPlace = 0;
        if ("$sum".length > 1) {
          secondPlace = int.parse("$sum".substring(1, 2));
        }
        return firstPlace + secondPlace;
      }
    }
    return 0;
  }

  /// The Internal Iqama/ID validation method.
  ///
  /// Checks [iqamaOrId] contains a valid saudi Iqama or National ID number
  /// Returns true if it contains a valid Iqama or ID, false otherwise
  static bool _validateIqamaNo(String iqamaOrId) {
    // Trimming spaces.
    iqamaOrId = iqamaOrId.trim();

    // Invalid length check: Iqama/ID should contain exactly 10 chars.
    int l = iqamaOrId.length;
    if (l != 10) {
      return false;
    }

    // Digits check: Iqama/ID should contain only digits
    if (!RegExp(r'^[0-9]+$').hasMatch(iqamaOrId)) {
      return false;
    }

    int s = (((int.parse(iqamaOrId.substring(1, 2)) +
                int.parse(iqamaOrId.substring(3, 4))) +
            int.parse(iqamaOrId.substring(5, 6))) +
        int.parse(iqamaOrId.substring(7, 8)));
    int tempS1 = 0;
    tempS1 = _evaluateBlock(_findBlockLength(iqamaOrId, 0), iqamaOrId, 0);
    s = (s + tempS1);
    int tempS2 = 0;
    tempS2 = _evaluateBlock(_findBlockLength(iqamaOrId, 2), iqamaOrId, 2);
    s = (s + tempS2);
    int tempS3 = 0;
    tempS3 = _evaluateBlock(_findBlockLength(iqamaOrId, 4), iqamaOrId, 4);
    s = (s + tempS3);
    int tempS4 = 0;
    tempS4 = _evaluateBlock(_findBlockLength(iqamaOrId, 6), iqamaOrId, 6);
    s = (s + tempS4);
    int tempS5 = 0;
    tempS5 = _evaluateBlock(_findBlockLength(iqamaOrId, 8), iqamaOrId, 8);
    s = (s + tempS5);
    int r = (10 - (s % 10));
    if (r == 10) {
      r = 0;
    }
    int tempS6 = int.parse(iqamaOrId.substring(9, 10));
    if (tempS6 == r) {
      return true;
    } else {
      return false;
    }
  }

  bool validateSaudiNationalID(String id) {
  // Check if the ID is exactly 10 digits
  if (!RegExp(r'^\d{10}$').hasMatch(id)) {  
    return false;
  }

  // Check if the first digit is 1 or 2
  int firstDigit = int.parse(id[0]);
  if (firstDigit != 1 && firstDigit != 2) {
    return false;
  }
   return true;
  // Checksum validation
  // int sum = 0;
  // for (int i = 0; i < 10; i++) {
  //   int digit = int.parse(id[i]);
  //   if (i % 2 == 0) { // even index
  //     digit *= 2;
  //     if (digit > 9) {
  //       digit -= 9;
  //     }
  //   }
  //   sum += digit;
  // }
  // return sum % 10 == 0;
}

}
