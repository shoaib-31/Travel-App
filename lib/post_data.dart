import 'package:flutter/material.dart';

class PostData extends ChangeNotifier {
  String origin = "";
  String destination = "";
  DateTime? travelDate; // Allow null for initial state
  int availableWeight = 0; // Use int for weight instead of string
  String weightAllowance = ""; // Keep string for user input

  // Update methods for individual fields

  void updateOrigin(String origin) {
    this.origin = origin;
    notifyListeners();
  }

  void updateDestination(String destination) {
    this.destination = destination;
    notifyListeners();
  }

  void updateTravelDate(DateTime travelDate) {
    this.travelDate = travelDate;
    notifyListeners();
  }

  void updateWeightAllowance(String weightAllowance) {
    this.weightAllowance = weightAllowance;
    final weight =
        int.tryParse(weightAllowance.replaceAll(RegExp(r'[^0-9]'), ''));
    if (weight != null) {
      availableWeight = weight;
    } else {
      availableWeight = 0; // Set to 0 if parsing fails
    }
    notifyListeners();
  }

  // Validation method to check for required fields
  bool isValid() {
    return origin.isNotEmpty && destination.isNotEmpty && travelDate != null;
  }
}
