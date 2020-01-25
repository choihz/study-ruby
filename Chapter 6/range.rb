# 1월에서 12월까지, 0에서 9까지, 덜 익히기(rare)에서 충분히 익히기(well done)까지, 쉰 번째 줄부터 예순일곱 번째 줄까지 등 실생활에서 범위(range)는 다양하게 사용된다. 따라서 루비가 실생활을 쉽게 모델링할 수 있으려면 범위를 지원해야 함은 당연하다. 다행히도 이 부분에서 루비는 대단히 훌륭한 언어다. 루비에서는 시퀀스(sequence), 조건(condition), 간격(interval)을 구현하는 데 범위를 사용한다.

# 범위의 첫 번째 용도이자 가장 자연스러운 사용법은 바로 시퀀스를 표현하는 것이다. 시퀀스는 시작값, 종료값을 비롯해 차례로 값을 만들어 내는 방법으로 이루어진다. 루비에서 시퀀스는 '..'과 '...' 범위 연산자를 이용해 만든다. 여기서 점 두 개로 이루어진 연산자는 경계를 포함하는 시퀀스를 만드는 반면 세 개로 이루어진 범위는 종료값 쪽의 경계를 포함하지 않는다.

1..10
'a'..'z'
0..."cat".length

# 범위는 to_a 메서드를 사용해 배열로 변환하거나, to_enum 메서드를 사용해 Enumerator 객체로 변환할 수 있다.

(1..10).to_a # => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
('bar'..'bat').to_a # => ["bar", "bas", "bat"]
enum = ('bar'..'bat').to_enum
puts enum.next
puts enum.next

# 범위는 구성 요소를 반복할 수 있는 메서드와 내용을 다양한 방법으로 검색할 수 있는 방법을 제공한다.

digits = 0..9
digits.include?(5) # => true
digits.max # => 9
digits.reject {|i| i < 5} # => [5, 6, 7, 8, 9]
digits.inject(:+) # => 45

# 지금까지는 숫자와 문자열로 이루어진 범위만 살펴보았다. 하지만 우리가 객체 지향 언어에 기대하는 바처럼 루비에서는 직접 만든 객체도 범위를 지원하도록 할 수 있다. 이를 위해서는 객체가 순서대로 다음 객체를 반환하는 succ 메서드를 구현해야 하고, 비교 연산자 <=>를 이용하여 비교 가능해야 한다. 때때로 우주선 연산자로 부르기도 하는 <=> 연산자는 두 값을 비교하여 첫째 값이 둘째 값보다 작으면 -1, 같으면 0, 크면 +1을 반환한다.
# 이렇게 사용하는 경우는 드물기 때문에 다음 예제는 조금 억지스러울지도 모른다. 다음 예제에는 2의 제곱수가 되는 수들을 나타내는 클래스가 있다. 여기에는 <=>와 succ가 정의되어 있으므로 이 클래스의 객체를 범위처럼 사용할 수 있다.

class PowerOfTwo
  attr_reader :value
  def initialize(value)
    @value = value
  end
  def <=>(other)
    @value <=> other.value
  end
  def succ
    PowerOfTwo.new(@value + @value)
  end
  def to_s
    @value.to_s
  end
end

p1 = PowerOfTwo.new(4)
p2 = PowerOfTwo.new(32)

puts (p1..p2).to_a

# 범위를 시퀀스로 사용하기도 하지만 조건절에 사용할 수도 있다. 조건절에서는 일종의 토글스위치처럼 작동한다. 이 스위치는 범위의 첫 부분에 있는 조건이 참이 되면 일단 켜진다. 그리고 둘째 부분의 조건이 참이 되면 꺼져 버린다. 예를 들어 다음 코드는 표준 입력에서 몇 부분을 출력한다. 여기서 출력되는 부분의 첫 줄은 단어 start를 포함하고 마지막 줄은 단어 end를 포함한다.

while line = gets
  puts line if line =~ /start/ .. line =~ /end/
end

# 이 코드는 한 줄을 읽을 때마다 범위 안에 포함되는지 여부를 판단한다.

# 다재다능한 범위의 마지막 용도는 어떤 값이 범위에 포함되는지 따지는 인터벌(interval) 테스트다. 이를 위해 case 문에서 사용하는 동등 연산자 ===를 이용한다.

(1..10) === 5 # => true
(1..10) === 15 # => false
(1..10) === 3.14159 # => true
('a'..'j') === 'c' # => true
('a'..'j') === 'z' # => false

# 간격 테스트는 case 문에서 자주 사용된다.

car_age = gets.to_f # 9.5가 입력되었다.
case car_age
when 0...1
  puts "Mmm.. new car smell"
when 1...3
  puts "Nice and new"
when 3...10
  puts "Reliable but slightly dinged"
when 10...30
  puts "Clunker"
else
  puts "Vintage gem"
end

# 앞선 예제는 범위의 마지막을 포함하지 않는 범위를 사용하고 있다는 점에 주목하자. case 문에서는 일반적으로 ...을 사용하는 것이 좋다. 다음과 같이 ..을 사용하면 9.5는 어떠한 범위에도 속하지 않게 되므로 else 다음에 나오는 표현들이 평가된다.

car_age = gets.to_f # 9.5가 입력되었다.
case car_age
when 0..0
  puts "Mmm.. new car smell"
when 1..2
  puts "Nice and new"
when 3..9
  puts "Reliable but slightly dinged"
when 10..29
  puts "Clunker"
else
  puts "Vintage gem"
end
