# 코드 블록(code block)은 마치 매개 변수처럼 메서드 호출과 결합할 수 있는 코드다. 이것은 루비가 가진 놀랄 만큼 강력한 기능이다.
# 코드 블록을 이용해 콜백을 구현할 수도 있고, 코드의 일부를 함수에 넘길 수 있고, 반복자를 구현할 수도 있다.
# 코드 블록은 중괄호나 do와 end로 묶인 코드다. 다음은 코드 블록의 예제다.

# { puts "Hello" }

# 다음 역시 코드 블록이다.

# do
#   club.enroll(person)
#   person.socialize
# end

# 왜 두 가지 방법이 모두 필요할까? 그 이유는 상황에 따라 더 자연스럽게 어울리는 방식이 있기 때문이다. 그리고 연산자 우선순위가 서로 다르다. 중괄호는 do/end 쌍보다 연산자 우선순위가 높다.
# 이 책에서는 되도록 루비의 표준 코드 양식을 따르려고 노력하는데, 이에 따라 한 줄의 코드 블록은 중괄호를, 여러 줄의 블록은 do/end를 사용한다.

# 블록을 만들었으니 이제 메서드 호출과 결합해 보자. 메서드를 호출하는 소스 코드의 맨 뒷부분에 코드 블록을 적어주기만 하면 된다.
# 예를 들어 다음 코드는 puts "Hi"를 실행하는 블록을 greet 메서드 호출과 결합하고 있다.

# greet { puts "Hi" }

# 메서드에 매개 변수가 있다면, 블록보다 앞에 써 준다.

# verbose_greet("Dave", "loyal customer") { puts "Hi" }

# 메서드에서는 루비의 yield 문을 이용해서 결합된 코드 블록을 여러 차례 실행할 수 있다. yield 문은 yield를 포함하는 메서드에 연관된 블록을 호출하는 메서드 호출로 생각해도 무방하다.

# 다음 예제에서는 yield를 두 번 호출하는 메서드를 정의하고 있다. 다음으로 이 메서드를 호출하고, 그리고 같은 줄에 블록을 넘겨준다(메서드에 매개 변수가 있다면 그 다음에).

def call_back
  puts "Start of method"
  yield
  yield
  puts "End of method"
end

call_back { puts "In the block" }

# 실행 결과
# Start of method
# In the block
# In the block
# End of method

# 블록 안에 있는 코드(puts "In the block")는 yield가 불릴 때마다 한 번씩 실행되어 총 두 번 실행된다.

# yield 문에 인자를 적으면 코드 블록에 이 값이 매개 변수로 전달된다. 블록 안에서 이러한 매개 변수를 넘겨받기 위해 |params|와 같이 세로 막대 사이에 매개 변수 이름들을 정의한다.
# 다음 예제에서는 메서드가 넘겨받은 블록을 2회 호출하고, 이때 블록에 인자를 넘겨준다.

def who_says_what
  yield("Dave", "hello")
  yield("Andy", "goodbye")
end

who_says_what { |person, phrase| puts "#{person} says #{phrase}" }

# 실행 결과
# Dave says hello
# Andy says goodbye

# 루비 라이브러리에서는 코드 블록을 반복자(iterator) 구현에 사용하기도 한다. 반복자란 배열 등의 집합에서 구성 요소를 하나씩 반환해 주는 함수를 의미한다.

animals = %w( ant bee cat dog ) # 배열을 하나 만든다.
animals.each { |animal| puts animal } # 배열의 내용을 반복한다.

# 실행 결과
# ant
# bee
# cat
# dog

# C나 자바에서 기본으로 지원하는 반복(제어)문은 루비에서는 단순히 메서드 호출일 뿐이다. 이 메서드는 결합된 블록을 여러 차례 반복 수행한다.

[ 'cat', 'dog', 'horse' ].each { |name| print name, " " }
5.times { print "*" }
3.upto(6) { |i| print i }
('a'..'e').each { |char| print char }
puts

# 실행 결과
# cat dog horse *****3456abcde

# 첫 번째 예제에서는 배열에 대해 각 요소를 블록에 넘겨준다.
# 두 번째 예제에서는 숫자 객체 5에 대해 블록을 다섯 번 호출한다.
# 세 번째 예제에서는 for 반복문을 사용하지 않고 숫자 3 객체가 6이 될 때까지 증가하면서 코드 블록을 수행하라고 메시지를 보낸다.
# 마지막으로 a에서 e까지의 범위(range) 각각에 대해 블록을 실행한다.
