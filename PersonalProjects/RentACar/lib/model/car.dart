import 'package:flutter/material.dart';

CarList carList = CarList(cars: [
  // Model 3
  Car(companyName: "Tesla", carModel: "Model 3", price: 70, imgsList: [
    "model3_back.png",
    "model3_front.png"
  ], carInformation: [
    {Icon(Icons.bluetooth, size: 30): "Automatic"},
    {Icon(Icons.airline_seat_individual_suite, size: 30): "4 Seats"},
    {Icon(Icons.flash_on, size: 30): "Electric"},
    {Icon(Icons.battery_charging_full, size: 30): "250 Mile Range"},
    {Icon(Icons.invert_colors, size: 30): "Colours"}
  ], carFeatures: [
    {Icon(Icons.bluetooth, size: 30): "Bluetooth"},
    {Icon(Icons.usb, size: 30): "USB Port"},
    {Icon(Icons.power_settings_new, size: 30): "Keyless"},
    {Icon(Icons.ac_unit, size: 30): "AC"},
    {Icon(Icons.event_seat, size: 30): "Seat Heater"}
  ], carSpecifications: [
    {
      Icon(Icons.av_timer, size: 30): {"Zero to 60": "4.5 Seconds"}
    },
    {
      Icon(Icons.power, size: 30): {"Charge Time": "50 Minutes"}
    },
    {
      Icon(Icons.drive_eta, size: 30): {"Hardware": "Autopilot HW 2.5"}
    },
    {
      Icon(Icons.account_balance_wallet, size: 30): {"More Specs": "Other"}
    }
  ]),
  // Model Y
  Car(companyName: "Tesla", carModel: "Model X", price: 90, imgsList: [
    "modelX_back.png",
    "modelX_front.png"
  ], carInformation: [
    {Icon(Icons.bluetooth, size: 30): "Automatic"},
    {Icon(Icons.airline_seat_individual_suite, size: 30): "6 Seats"},
    {Icon(Icons.flash_on, size: 30): "Electric"},
    {Icon(Icons.battery_charging_full, size: 30): "350 Mile Range"},
    {Icon(Icons.invert_colors, size: 30): "Colours"}
  ], carFeatures: [
    {Icon(Icons.bluetooth, size: 30): "Bluetooth"},
    {Icon(Icons.usb, size: 30): "USB Port"},
    {Icon(Icons.power_settings_new, size: 30): "Keyless"},
    {Icon(Icons.ac_unit, size: 30): "AC"},
    {Icon(Icons.event_seat, size: 30): "Seat Heater"}
  ], carSpecifications: [
    {
      Icon(Icons.av_timer, size: 30): {"Zero to 60": "4.1 Seconds"}
    },
    {
      Icon(Icons.power, size: 30): {"Charge Time": "55 Minutes"}
    },
    {
      Icon(Icons.drive_eta, size: 30): {"Hardware": "Full-Self Driving HW 2.5"}
    },
    {
      Icon(Icons.account_balance_wallet, size: 30): {"More Specs": "Other"}
    }
  ]),
  // Model S
  Car(companyName: "Tesla", carModel: "Model S", price: 80, imgsList: [
    "modelS_back.png",
    "modelS_front.png"
  ], carInformation: [
    {Icon(Icons.bluetooth, size: 30): "Automatic"},
    {Icon(Icons.airline_seat_individual_suite, size: 30): "4 Seats"},
    {Icon(Icons.flash_on, size: 30): "Electric"},
    {Icon(Icons.battery_charging_full, size: 30): "450 Mile Range"},
    {Icon(Icons.invert_colors, size: 30): "Colours"}
  ], carFeatures: [
    {Icon(Icons.bluetooth, size: 30): "Bluetooth"},
    {Icon(Icons.usb, size: 30): "USB Port"},
    {Icon(Icons.power_settings_new, size: 30): "Keyless"},
    {Icon(Icons.ac_unit, size: 30): "AC"},
    {Icon(Icons.event_seat, size: 30): "Seat Heater"}
  ], carSpecifications: [
    {
      Icon(Icons.av_timer, size: 30): {"Zero to 60": "3.1 Seconds"}
    },
    {
      Icon(Icons.power, size: 30): {"Charge Time": "40 Minutes"}
    },
    {
      Icon(Icons.drive_eta, size: 30): {"Hardware": "Full-Self Driving HW 3"}
    },
    {
      Icon(Icons.account_balance_wallet, size: 30): {"More Specs": "Other"}
    }
  ])
]);

class CarList {
  List<Car> cars;

  CarList({
    @required this.cars,
  });
}

class Car {
  String companyName;
  String carModel;
  int price;
  List<String> imgsList;
  List<Map<Icon, String>> carInformation;
  List<Map<Icon, String>> carFeatures;
  List<Map<Icon, Map<String, String>>> carSpecifications;

  Car(
      {@required this.companyName,
      @required this.carModel,
      @required this.price,
      @required this.imgsList,
      @required this.carInformation,
      @required this.carFeatures,
      @required this.carSpecifications});
}
