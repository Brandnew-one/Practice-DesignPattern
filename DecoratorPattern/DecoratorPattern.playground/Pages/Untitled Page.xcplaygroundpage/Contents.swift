import Foundation

protocol Beverage {
  var description: String { get }

  func getDescription() -> String
  func cost() -> Int
}

class HouseBlend: Beverage {
  var description: String {
    return "HouseBlend Coffee"
  }

  func getDescription() -> String {
    return description
  }

  func cost() -> Int {
    return 4300
  }
}

class DarkRoast: Beverage {
  var description: String {
    return "DarkRoast Coffee"
  }

  func getDescription() -> String {
    return description
  }

  func cost() -> Int {
    return 4300
  }
}

// MARK: - 해결방법 1
// 우유, 모카, 휘핑크림과 같은 옵션이 추가되는 경우
class HouseBlendWithSteamMilkandMocah: Beverage {
  var description: String {
    return "HouseBlend With SteamMilk and Mocah Coffee"
  }

  func getDescription() -> String {
    return description
  }

  func cost() -> Int {
    return 4300 + 500 + 500
  }
}

class HouseBlendWithMocah: Beverage {
  var description: String {
    return "HouseBlend With Mocah Coffee"
  }

  func getDescription() -> String {
    return description
  }

  func cost() -> Int {
    return 4300 + 500
  }
}
