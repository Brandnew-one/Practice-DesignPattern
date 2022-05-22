import Foundation

protocol Beverage {
  var description: String { get }
  func cost() -> Int
}

protocol Decorator: Beverage {
  var beverage: Beverage { get set }
}

class Milk: Decorator {
  var beverage: Beverage
  var description: String {
    return self.beverage.description + "Milk"
  }

  init(beverage: Beverage) {
    self.beverage = beverage
  }

  func cost() -> Int {
    return self.beverage.cost() + 500
  }
}

class Whip: Decorator {
  var beverage: Beverage
  var description: String {
    return self.beverage.description + "Whip"
  }

  init(beverage: Beverage) {
    self.beverage = beverage
  }

  func cost() -> Int {
    return self.beverage.cost() + 500
  }
}

class HouseBlend: Beverage {
  var description: String {
    return "House Blend Coffee"
  }

  func cost() -> Int {
    return 4300
  }
}

class Decaf: Beverage {
  var description: String {
    return "Decaf Coffee"
  }

  func cost() -> Int {
    return 4300
  }
}

let whipHouseblend = Whip(beverage: HouseBlend())
whipHouseblend.cost()
whipHouseblend.description

let whipmilkDefac = Whip(beverage: Milk(beverage: Decaf()))
whipmilkDefac.description
whipmilkDefac.cost()


class Soy: Decorator {
  var beverage: Beverage
  var description: String {
    return self.beverage.description + "Soy"
  }

  init(beverage: Beverage) {
    self.beverage = beverage
  }

  func cost() -> Int {
    return self.beverage.cost() + 600
  }
}

let soyHouseBlend = Soy(beverage: HouseBlend())
print(soyHouseBlend.description)
