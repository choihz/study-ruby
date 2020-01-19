# 모듈에는 또 다른 훌륭한 사용법이 있다. 바로 믹스인이라는 기능인데, 이를 이용하면 많은 경우 다중 상속을 할 필요가 사라진다.
# 앞의 예제에서 모듈 메서드를 정의했는데, 이 메서드 이름 앞에는 모듈 이름이 붙어 있다. 이것을 보고 클래스 메서드를 떠올렸다면, 다음에는 이런 생각이 들 것이다. "모듈 안에 인스턴스 메서드를 정의하면 어떻게 되는 걸까?"

# 모듈은 인스턴스를 가질 수 없다. 클래스가 아니기 때문이다. 하지만 클래스 선언에 모듈을 포함할 수 있다. 모듈을 포함하면 이 모듈의 모든 인스턴스 메서드는 갑자기 클래스의 인스턴스 메서드처럼 동작하기 시작한다. 즉, 이 메서드가 클래스에 녹아서 섞여 버린(mixed in) 것이다. 믹스인된 모듈은 실제로는 일종의 부모 클래스처럼 동작한다.

module Debug
  def who_am_i?
    "#{self.class.name} (id: #{self.object_id}): #{self.name}"
  end
end

class Phonograph
  include Debug
  attr_reader :name
  def initialize(name)
    @name = name
  end
  # ...
end

class EightTrack
  include Debug
  attr_reader :name
  def initialize(name)
    @name = name
  end
  # ...
end

ph = Phonograph.new("West End Blues")
et = EightTrack.new("Surrealistic Pillow")

puts ph.who_am_i?
puts et.who_am_i?

# 앞선 예제에서는 Debug 모듈을 포함함으로써 Phonograph와 EightTrack 둘 다 who_am_i? 인스턴스 메서드를 이용할 수 있게 되었다.
# include 문을 사용하기 전에 짚고 넘어갈 부분이 두 가지 있다.
# 먼저 이것은 파일과 관련해 아무런 일도 하지 않는다는 점이다. C 개발자는 #include라는 전처리기(preprocessor)를 이용하는데, 이는 컴파일 중 해당 코드 내용을 다른 파일에 추가시킨다. 루비의 include 구문은 단지 해당 모듈에 대한 참조를 만들 뿐이다. 모듈이 분리된 파일에 있을 경우 include를 사용하기 전에 해당 파일을 require해야 한다.
# 두 번째로 루비의 include는 단순히 클래스에 모듈의 인스턴스 메서드를 복사하는 것이 아니다. 그 대신 include는 클래스에 포함될 모듈에 대한 참조를 만든다. 여러 클래스가 하나의 모듈을 포함한다면(include) 이 클래스들은 모두 같은 모듈을 참조하게 된다. 모듈의 메서드 정의를 수정한다면, 이 모듈을 포함하는 모든 클래스는 새로이 정의된 방식으로 동작할 것이다.

# 믹스인은 클래스에 새로운 기능을 추가하는 멋진 방법을 제공한다. 하지만 믹스인의 진정한 힘은 믹스인되는 코드가 자신을 이용하는 클래스와 상호 작용할 때 드러난다. Comparable 같은 일반적인 루비의 믹스인을 예로 들어보자. Comparable 믹스인을 포함하면 클래스에 비교 연산자(<, <=, ==, >=, >)와 between? 메서드가 추가된다. 이를 가능케 하기 위해 Comparable 모듈은 이를 인클루드하는 클래스에 <=> 연산자가 정의되어 있다고 가정한다. 그러므로 클래스를 만들 때 <=>를 정의하고 Comparable을 포함하는 작은 수고로 여섯 개의 비교 함수를 얻을 수 있다.
# 이 기능을 Person 클래스에 이용해 보자. 여기서는 사람들의 이름을 비교할 것이다.

class Person
  include Comparable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "#{@name}"
  end

  def <=>(other)
    self.name <=> other.name
  end
end

p1 = Person.new("Matz")
p2 = Person.new("Guido")
p3 = Person.new("Larry")

# 이름을 비교해 본다.
if p1 > p2
  puts "#{p1.name}'s name > #{p2.name}'s name"
end

# Person 객체들의 배열을 정렬한다.
puts "Sorted list:"
puts [p1, p2, p3].sort

# Person 클래스에 Comparable 모듈을 인클루드하고 <=>를 정의한다. 이를 통해 p1 > p2와 같이 비교가 가능해지고, Person 객체들을 순서대로 정렬하는 것도 가능해진다.

# C++ 같은 몇몇 객체 지향 언어에서는 다중 상속을 지원한다. 이를 통해 하나의 클래스는 여러 개의 부모 클래스를 가질 수 있으며 이들로부터 각각의 기능을 상속받는다. 이는 매우 강력한 개념이지만 상속 계층을 애매모호하게 만든다는 점에서 동시에 매우 위험한 기능이기도 하다.
# 자바나 C# 같은 여타 언어에서는 단일 상속만을 지원한다. 이러한 언어에서는 클래스는 직접적인 부모 클래스를 하나만 가질 수 있다. 단일 상속은 깔끔하며 구현하기도 쉽지만 분명한 단점이 있다. 현실 세계에서 객체는 다양한 곳에서 속성들을 상속받는다(예를 들어 공은 튕기는 물건인 동시에 구형인 물건이다). 루비는 단일 상속의 단순함과 다중 상속의 강력함을 누릴 수 있는 매우 흥미롭고도 강력한 타협안을 제시한다. 루비 클래스는 직접적으로 단 하나의 부모 클래스만을 가질 수 있다. 바로 이러한 점에서 루비는 단일 상속만을 지원하는 언어다. 하지만 루비의 클래스는 믹스인(믹스인은 클래스의 부분 정의를 가지고 있는 모듈이다)을 얼마든지 가질 수 있다. 이를 통해 다중 상속의 약점을 피해가면서 다중 상속을 간접적으로 지원하고 있다.
