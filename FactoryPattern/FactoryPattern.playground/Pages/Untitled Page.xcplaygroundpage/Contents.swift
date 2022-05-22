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

class Park {
  
  func go() {
    let hundai = Car(brandName: "Hundai")
    hundai.ride()
  }
}
