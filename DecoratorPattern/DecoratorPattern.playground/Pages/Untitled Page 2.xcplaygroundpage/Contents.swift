import Foundation

protocol Beverage {
  var description: String { get }
  var milk: Bool { get }
  var mocha: Bool { get }
  var whip: Bool { get }

  func getDescription() -> String
  func cost() -> Int
}

class HouseBlend: Beverage {
  var description: String {
    return "House Blend Coffee"
  }

  var milk: Bool
  var mocha: Bool
  var whip: Bool

  func getDescription() -> String {
    var originDescription = description
    if milk || mocha || whip {
      originDescription += "With"
    }
    if milk {
      originDescription += "milk"
    }
    if mocha {
      originDescription += "mocha"
    }
    if whip {
      originDescription += "whip"
    }
    return originDescription
  }

  func cost() -> Int {
    var originPrice = 4300
    if milk {
      originPrice += 500
    }
    if mocha {
      originPrice += 500
    }
    if whip {
      originPrice += 500
    }
    return originPrice
  }

  init(milk: Bool, mocha: Bool, whip: Bool) {
    self.milk = milk
    self.mocha = mocha
    self.whip = whip
  }
}

let a = HouseBlend(milk: true, mocha: false, whip: false)
a.cost()
a.getDescription()

class Decaf: Beverage {
  var description: String {
    return "Decaf Coffee"
  }

  var milk: Bool
  var mocha: Bool
  var whip: Bool

  func getDescription() -> String {
    var originDescription = description
    if milk || mocha || whip {
      originDescription += "With"
    }
    if milk {
      originDescription += "milk"
    }
    if mocha {
      originDescription += "mocha"
    }
    if whip {
      originDescription += "whip"
    }
    return originDescription
  }

  func cost() -> Int {
    var originPrice = 4300
    if milk {
      originPrice += 500
    }
    if mocha {
      originPrice += 500
    }
    if whip {
      originPrice += 500
    }
    return originPrice
  }

  init(mocha: Bool, whip: Bool) {
    self.milk = false
    self.mocha = mocha
    self.whip = whip
  }
}
