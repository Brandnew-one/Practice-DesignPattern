# Decorator Pattern

```swift
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
```

스타벅스를 예로 들어보겠습니다. 현재 커피숍에서는 기본적으로 원두를 선택해서 커피를 살 수 있습니다. 그럼 위와 같이 원두별로 가격을 측정해서 기본적인 클래스를 만들 수 있습니다.

하지만 메뉴들이 늘어나면서 기본적인 원두뿐만 아니라 우유, 휘핑크림, 모카등 다양한 옵션들을 추가할 수 있습니다. 그럼 위의 구조를 어떻게 변경해야 할까요?

```swift
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
```

위와 같이 모든 종류의 커피에 대한 클래스를 만들어주는 것도 하나의 방법이 될 수 있습니다.

하지만 추가적인 옵션이 많아질 경우에는 정말 많은 클래스를 생성해야 하는 문제점이 있습니다.

```swift
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
```

그럼 추가될 옵션들을 Bool로 선언하고 해당 옵션들의 유무에 따라 다른 값들을 출력하도록 설정하면 어떨까요?

그럼 가장 기본이 될 원두의 개수 만큼만 클래스를 생성하면 모든 case를 대비할 수 있으니 이전 보다는 선언해야 할 클래스 개수가 줄어들겠죠!

`그런데 만약 본사에서 두유라는 옵션을 추가하면 어떻게 될까요?`

- Beverage 프로토콜에 soy라는 저장 프로퍼티를 추가하고
- 해당 프로토콜을 채택한 모든 클래스에 soy를 추가하고
- cost 메서드를 변경하고
- getDescription 메서드를 변경하고
- 생성자를 변경해야 겠죠?

간단하게 생각해봐도 바꿔야 할것들이 많죠? 그럼 또 다른 case를 가정해보겠습니다. 본사에서 디카페인 원두를 사용한 커피에는 우유를 절대 넣어서 팔지말라는 방침이 내려왔습니다.

```swift
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
```

그럼 단순하게 생성자에서 milk = false 처리를 해주면 문제를 해결할 수 있습니다.

하지만`Decaf` 클래스 milk라는 저장프로퍼티를 가지고 있을 필요가 있을까요? `ISP`  

위의 문제를 데코레이터 패턴을 적용하면 어떻게 되는지 한법 확인해보겠습니다.

<img width="859" alt="스크린샷_2022-05-22_오후_4 09 20" src="https://user-images.githubusercontent.com/88618825/169684349-6527a3aa-c088-4efd-a18b-04a8cd03c3ff.png">

먼저 구조를 가시적으로 살펴보면 위와 같습니다.

- Beverage 프토토콜(추상클래스)를 채택하는(구현하는) 기본적인 원두에 따른 클래스들 `House, Decaf`
- Beverage 프로토콜을 채택함과 동시에 소유하고 있는 `Decorator`

Decorator는 왜 Beverage를 채택하면서(상속) 동시에 소유하고 있어야 할까요? 코드를 먼저 보겠습니다.

```swift
protocol Beverage {
  var description: String { get }
  func cost() -> Int
}
// 위의 그림과 똑같죠? Decorator가 Beverage를 채택하고(상속받고) 있습니다.
protocol Decorator: Beverage {
  var beverage: Beverage { get set } // 왜 데코레이터가 beverage를 소유해야 할까요? - 아래
}
```

```swift
class HouseBlend: Beverage {
  var description: String {
    return "House Blend Coffee"
  }
  func cost() -> Int {
    return 4300
  }
}
// 기본원두 클래스들은 Beverage를 채택하면 되겠죠?
class Decaf: Beverage {
  var description: String {
    return "Decaf Coffee"
  }
  func cost() -> Int {
    return 4300
  }
}
```

이제 핵심이라고 할 수 있는 추가 옵션들을 어떻게 정의하는지 보겠습니다!

```swift
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

let whipHouseblend = Whip(beverage: HouseBlend())
whipHouseblend.cost() // 4800
whipHouseblend.description // House Blend CoffeeWhip

let whipmilkDefac = Whip(beverage: Milk(beverage: Decaf()))
whipmilkDefac.description // Decaf CoffeeMilkWhip
whipmilkDefac.cost() // 5300
```

데코레이터는 자신이 장식하고 있는 객체와(Beverage) 같은 슈퍼클래스를 가지고 있기 때문에 원래 객체가 들어갈 자리에 데코레이터 객체를 넣어도 상관없습니다.

`Decorator는 Beverage를 상속받기 때문에 Beverage가 들어갈 자리에 Decorator를 넣어도 상관없다`

그럼 이전의 문제들이 어떻게 해결되는지 확인 해보겠습니다.

```swift
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
```

두유라는 새로운 옵션이 추가되는 경우, Decorator를 채택하는 새로운 Soy라는 클래스를 만들기만 하면 됩니다!

그리고 Decaf 원두 커피에는 milk를 추가할 수 없다는 방침은 Decaf 클래스에는 어떤 옵션도 저장하고 있지 않기 때문에 전혀 문제가 되지 않는 모습을 확인 할 수 있습니다!
