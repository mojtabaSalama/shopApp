import 'package:flutter/material.dart';
import 'package:shop_app/models/customer.dart';

class CustomerProvider extends ChangeNotifier {
  List<Customer> _customers = [];

  Customer? authCustomer;

  List<Customer> get customers => _customers;

  bool signUp(Customer customer) {
    if (_customers.any((existingCustomer) =>
        existingCustomer.name == customer.name &&
        existingCustomer.password == customer.password)) {
      return false; // Customer already exists in _customers list
    }

    _customers.add(customer);
    authCustomer = customer;
    notifyListeners();
    return true; // Customer added successfully
  }

  bool signIn(Customer customer) {
    if (_customers.any((existingCustomer) =>
        existingCustomer.name == customer.name &&
        existingCustomer.password == customer.password)) {
      authCustomer = customer;

      return true;
    } else {
      return false;
    }
  }

  bool signout() {
    if (authCustomer != null) {
      authCustomer = null;

      return true;
    } else {
      return false;
    }
  }
}
