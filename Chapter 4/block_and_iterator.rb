# 단어의 출현 빈도를 분석하는 프로그램에는 다음과 같은 반복문이 포함되어 있었다.

# for i in 0..4
#   word = top_five[i][0]
#   count = top_five[i][1]
#   puts "#{word}: #{count}"
# end

# 이 코드는 문제없이 작동한다. 그리고 배열을 반복하는 for 루프는 매우 익숙할 것이다. 이보다 자연스러운 코드가 있을까?
# 하지만 더 자연스러운 방법이 있다. 앞의 방법은 반복이 배열과 지나치게 밀접하다. 반복이 다섯 번만 일어난다는 사실을 알고 있어야 하며 배열에서 순서대로 값을 가져와야만 한다. 심지어 처리하는 대상의 구조가 요소 두 개를 가진 서브배열들의 배열이라는 사실도 알아야 한다. 모든 것이 지나치게 결합되어 있다.
# 앞의 코드와 같은 일을 하는 코드를 다음과 같이 작성할 수도 있다.

# top_five.each do |word, count|
#   puts "#{word}: #{count}"
# end

# each 메서드는 반복자라고 불리며 주어진 블록의 코드를 반복적으로 호출한다. 더 나아가 다음과 같이 더 간결한 코드를 작성하는 프로그래머도 있다.

# puts top_five.map { |word, count| "#{word}: #{count}" }

# 얼마나 간결하게 작성할지는 어디까지나 취향의 문제다. 어떤 식으로 코드를 작성하건 루비에서 반복자와 코드 블록은 매우 흥미로운 주제 중 하나이다.

# 블록은 중괄호나 do와 end 키워드로 둘러싸인 코드 덩어리다. 바로 앞에서 살펴본 블록을 표현하는 두 가지 방법은 연산자 우선순위를 제외하면 완전히 같다. 어느 쪽을 사용해도 결과는 같지만 루비 프로그래머들은 일반적으로 한 줄에 블록을 작성할 수 있다면 중괄호를 사용하고, 그렇지 않으면 do/end 블록을 사용한다.

# some_array.each {|vaule| puts value * 3}

# sum = 0
# other_array.each do |value|
#   sum += value
#   puts value / sum
# end

# 블록은 익명 메서드의 본문과 비슷한 무언가라고 생각해도 무방하다. 메서드와 마찬가지로 블록도 매개 변수를 받을 수 있다(단, 메서드와 달리 넘겨받는 매개 변수를 표현할 때 블록의 시작 부분에 두 개의 막대(|) 사이에 이름을 넣어준다). 앞선 예제에서는 둘 다 value라는 하나의 매개 변수를 받는다. 또한 메서드와 마찬가지로 블록은 루비가 처음 이 부분을 해석하는 동안에는 실행되지 않는다. 실행하는 대신 이후에 호출할 수 있도록 블록을 저장해 둔다.

# 루비 소스 코드에서 블록은 반드시 메서드 호출 바로 다음에 위치해야 한다. 메서드가 매개 변수를 받는다면 블록은 이들 매개 변수에 이어진다. 다르게 생각해 보면 블록은 메서드에 넘겨지는 추가적인 매개 변수라고 봐도 무방하다.
# 다음 예제에서는 배열의 각 요소의 제곱의 합을 구한다.

sum = 0
[1, 2, 3, 4].each do |value|
  square = value * value
  sum += square
end
puts sum

# 블록은 각 배열 요소에 대해 한 번씩 호출된다. 각 요소는 값 매개 변수로 블록에 전달된다. 여기서 주의해야 할 부분이 있다. 앞선 예제에서 sum 변수에 주목해 보자. 이 변수는 블록 밖에서 정의되어 있으며, 블록 안에서 갱신되고 each 메서드가 종료된 뒤에 puts 메서드에 넘겨진다.
# 이를 통해 중요한 규칙 하나를 알 수 있다. 블록 밖에서 선언되고 이와 같은 이름의 변수가 블록 내에서 사용될 때 두 변수는 같은 변수다. 따라서 앞선 예제에서 sum 이름을 가지는 변수는 단 하나밖에 없다(뒤에서 다루겠지만 이러한 작동 방식을 변경할 수도 있다).
# 하지만 변수가 블록 안에만 있다면 이 변수는 블록 내부에서만 사용하는 지역 변수가 된다. 따라서 앞선 예제에서 square의 값은 출력할 수 없다. square는 블록 내부에서만 사용되는 변수로 블록 밖에는 정의되어 있지 않기 때문이다.
# 이러한 규칙은 단순하지만 생각하지 못한 실수를 유발할 수 있다. 예를 들어 다양한 도형을 그리는 프로그램을 만들고 있다고 가정해 보자. 그 코드는 다음과 같다.

# square = Shape.new(sides: 4) # Shape는 다른 곳에 정의되어 있다
# ... 프로그램 상세 구현 내용
# sum = 0
# [1, 2, 3, 4].each do |value|
#   square = value * value
#   sum += square
# end
# puts sum
# square.draw

# 이 코드는 생각한 대로 작동하지 않는다. square 변수에는 Shape 객체가 저장되어 있는데 블록에서 덮어 쓰여서 each 메서드가 끝난 시점에는 단순한 숫자 값이 저장되어 있다. 이러한 문제가 자주 발생하지는 않지만, 일단 발생하면 발견하기 힘들다.

# 다행히도 루비에서는 이를 해결하기 위한 몇 가지 기능이 있다.
# 첫 번째는 블록에 넘겨지는 매개 변수는 항상 블록의 지역 변수로 다뤄진다. 이는 블록 밖에 같은 이름을 가진 변수가 있어도 적용되는 규칙이다(단, 루비를 -w 플래그와 함께 실행한다면 경고가 발생한다).

value = "some shape"
[1, 2].each {|value| puts value}
puts value

# 다음으로 블록 매개 변수 리스트에서 필요한 변수 앞에 세미콜론을 붙이면 명시적으로 블록의 지역 변수라는 것을 지정할 수 있다. 앞서 각 숫자의 제곱의 합을 구하는 예제에서 다음과 같이 square 변수 앞에 세미콜론을 사용해 블록에서만 사용하는 지역 변수임을 명시할 수 있다.

square = "some shape"

sum = 0
[1, 2, 3, 4].each do |value; square|
  square = value * value # 앞에서 정의한 square와는 다른 변수다
  sum += square
end
puts sum
puts square

# square 변수를 지역 변수로 만들어 블록 내에서 변수를 대입하더라도 블록 밖의 스코프에 존재하는 같은 이름의 변수에는 영향을 주지 않는다.

# 루비에서 반복자란 코드 블록을 호출할 수 있는 메서드를 이야기한다.
# 앞서 소스 코드에서 블록은 메서드를 호출한 바로 다음에만 나온다는 것과 코드 블록은 루비 해석기가 이를 해석하는 순간에 실행되는 것이 아니라고 이야기했다. 대신에 루비는 지역 변수, 현재 객체 등과 같은 블록이 나타난 시점의 맥락을 저장해 두고 메서드를 실행해 나간다. 바로 여기서 마법이 시작된다.
# 메서드에서 yield 문을 사용해서 마치 코드 블록을 하나의 메서드인 것처럼 호출할 수 있다. yield를 사용하면 메서드 안에서 언제라도 코드 블록을 호출할 수 있다. 블록이 끝나면 yield 문 바로 다음부터 메서드가 실행된다. 다음은 yield를 사용하는 간단한 예제다.

def two_times
  yield
  yield
end
two_times { puts "Hello" }

# 블록(중괄호 사이의 코드)은 two_times 메서드의 호출에 연관 지어졌다. 이 메서드에서 yield는 두 번 호출된다. yield가 호출될 때마다 블록의 코드가 실행되며 Hello가 출력된다. 블록이 재미있는 점은 매개 변수를 블록에 넘겨줄 수도 있고 블록의 실행 결과를 다시 받아올 수도 있다는 점이다. 다음은 특정 숫자까지 피보나치수열을 출력하는 간단한 예제 프로그램이다.

def fib_up_to(max)
  i1, i2 = 1, 1 # 병렬 대입 (i1 = 1, i2 = 1)
  while i1 <= max
    yield i1
    i1, i2 = i2, i1 + i2
  end
end

fib_up_to(1000) {|f| print f, " "}
puts

# 이 예제에서 yield는 매개 변수를 가진다. 이 매개 변수는 연관 지어진 블록으로 넘겨진다. 블록을 정의할 때 이러한 인자 목록은 블록 첫 부분의 막대(|) 사이에 나열한다. 앞선 예제에서는 yield에 지정한 매개 변수 f가 블록에 넘겨지며, 따라서 블록에서는 수열의 각 항목을 출력한다. 블록의 인자는 하나인 경우가 많지만 인자의 수에 제한이 있는 것은 아니다.
# 몇몇 반복자는 다양한 루비 컬렉션 객체에 사용된다. each, collect, find에 대해 살펴보자.

# each는 가장 간단한 반복자다. 다음과 같이 컬렉션의 각 요소에 대해 yield를 실행할 뿐이다.

[ 1, 3, 5, 7, 9 ].each {|i| puts i}

# each 반복자는 루비에서 특별한 의미가 있다. 지금은 다루지 않지만, 뒤에서는 each를 사용해 루비의 for 루프를 구현하는 방법과 클래스에 each 메서드의 구현을 통해 더 많은 기능을 이용하는 법을 살펴볼 것이다.
# 또한 블록은 메서드에 자신의 평가 결과를 반환한다. 블록의 마지막 표현식을 평가한 결과는 yield의 결괏값으로 메서드에 반환된다. 이는 Array 클래스의 find 메서드가 작동하는 원리이기도 하다. 그 구현은 다음과 비슷하다.

class Array
  def find
    each do |value|
      return value if yield(value)
    end
    nil
  end
end

[1, 3, 5, 7, 9].find {|v| v * v > 30} # => 7

# 여기서는 each를 사용해 다음 요소를 연관된 블록에 넘겨준다. 이때 블록이 true를 반환하면(즉, 값이 nil이나 false가 아니라면), 메서드는 이에 해당하는 요소를 즉시 반환한다. 매치하는 요소가 없다면 메서드는 nil을 반환한다. 앞선 예제는 반복자를 사용하는 장점을 보여준다. Array 클래스가 배열의 각 요소를 탐색하는 기능을 제공함으로써, 애플리케이션 코드를 통해 자신의 목적에 집중할 수 있도록 도와준다. 앞의 코드의 목적은 특정한 조건을 만족하는 요소를 찾는 일이다.

# 자주 사용되는 또 다른 반복자는 collect다. map이라고도 불리는 이 메서드는, 컬렉션으로부터 각 요소를 넘겨받아 이를 블록에 넘겨준다. 그리고 블록을 평가한 결괏값을 모은 새로운 배열을 만들어 반환한다. 다음 예제는 알파벳 다음 문자를 반환하는 succ 메서드를 블록에서 사용하고 있다.

["H", "A", "L"].collect {|x| x.succ} # => ["I", "B", "M"]

# 반복자는 배열이나 해시 안의 데이터에만 접근 가능한 것은 아니다. 피보나치수열의 예에서 살펴보았듯이 반복자는 유도된 값을 반환할 수 있다. 이 기능은 루비의 입출력 클래스에서 사용된다. 입력 클래스에는 이어지는 줄(또는 바이트)을 I/O 스트림으로 반환하는 반복자 인터페이스가 구현되어 있다.

f = File.open("testfile")
f.each do |line|
  puts "The line is: #{line}"
end
f.close

# 블록이 몇 번 실행되었는지에 대한 정보가 필요한 경우가 있다. 이때는 with_index 메서드가 도움을 줄 것이다. with_index는 반복자 호출 다음에 연속해서 사용할 수 있으며, 반복자에 의해 반환되는 각 값에 자신의 위치를 숫자로 추가한다. 이를 통해 원래의 값과 위치를 나타내는 숫자가 같이 블록에 넘겨진다.

f = File.open("testfile")
f.each.with_index do |line, index|
  puts "Line #{index} is: #{line}"
end
f.close

# 유용한 반복자를 하나 더 살펴보자. Enumerable에 정의되어 있는 조금 불분명해 보이는 inject라는 이름의 메서드는 컬렉션의 모든 멤버에 걸쳐 특정한 연산을 누적해서 적용할 수 있도록 해 준다. 예를 들어 배열 내의 모든 요소의 합계나 곱을 구하고자 할 때 다음과 같이 작성할 수 있다.

[1, 3, 5, 7].inject(0) {|sum, element| sum + element} # => 16
[1, 3, 5, 7].inject(1) {|product, element| product * element} # => 105

# inject의 작동 원리는 이렇다. 맨 처음 sum을 inject에 넘겨진 매개 변수로 초기화하고 연관된 블록을 호출한다. 그리고 컬렉션의 첫 번째 요소를 element로 블록에 넘긴다. 두 번째부터 sum의 값은 바로 전에 실행된 블록이 반환한 값이 된다. 그리고 inject의 결괏값은 마지막에 실행된 블록이 반환한 값이 된다. 이 메서드를 다르게 사용할 수도 있다. 매개 변수 없이 inject를 호출하면 컬렉션의 첫 번째 요소가 초깃값이 되고 두 번째 요소부터 반복을 시작한다. 따라서 앞의 코드를 다음과 같이 좀 더 간결하게 작성할 수 있다.

[1, 3, 5, 7].inject {|sum, element| sum + element} # => 16
[1, 3, 5, 7].inject {|product, element| product * element} # => 105

# inject를 더욱 간결하게 사용할 수 있는 방법도 있다. 직접 컬렉션에서 적용하고자 하는 메서드의 이름을 inject에 직접 지정할 수 있다. 루비에서 더하기(+)나 곱하기(*) 연산자는 숫자에 사용 가능한 메서드이지만 :+와 :*는 각 연산자를 나타내는 심벌이기 때문에 다음 예제는 정상으로 작동한다.

[1, 3, 5, 7].inject(:+) # => 16
[1, 3, 5, 7].inject(:*) # => 105
