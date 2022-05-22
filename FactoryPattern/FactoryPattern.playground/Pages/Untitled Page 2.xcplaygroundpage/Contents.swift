import Foundation

protocol Rideable {
  var brandName: String { get }
  func ride()
}

class Car: Rideable {
  var brandName: String

  init(brandName: String) {
    self.brandName = brandName
  }

  func ride() {
    print("\(brandName) 자동차를 탑니다!")
  }
}

class Bicycle: Rideable {
  var brandName: String

  init(brandName: String) {
    self.brandName = brandName
  }

  func ride() {
    print("\(brandName) 자전거를 탑니다!")
  }
}


enum VehicleType {
  case car, bicycle
}

class VehicleFactory {
  func createVehicle(type: VehicleType, brandName: String) -> Rideable {
    switch type {
    case .car:
      return Car(brandName: brandName)
    case .bicycle:
      return Bicycle(brandName: brandName)
    }
  }
}

class Park {
  func go() {
    let vehicleFactory = VehicleFactory()
    let hyundai = vehicleFactory.createVehicle(type: .car, brandName: "Hyundai")
  }
}
