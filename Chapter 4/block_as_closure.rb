# 앞서 블록 내부에서 블록의 외부 스코프에 있는 지역 변수도 참조 가능하다는 설명을 했다. 이를 사용해 다음과 같이 조금 특이하게 블록을 활용할 수도 있다.

def n_times(thing)
  lambda {|n| thing * n}
end

p1 = n_times(23)
p1.call(3) # => 69
p1.call(4) # => 92
p2 = n_times("Hello ")
p2.call(3) # => "Hello Hello Hello "

# n_times 메서드는 이 메서드의 매개 변수 thing을 참조하는 Proc 객체를 반환한다. 이 매개 변수는 블록이 호출될 때 스코프 범위 밖에 있지만 블록에서는 당연한 듯이 사용할 수 있다. 이를 클로저라고 한다.
# 블록 내부에서 참조하고 있는 변수는 블록을 벗어난 시점에서도 이 블록이 존재하는 한, 또는 이 블록에서 생성된 Proc 객체가 존재하는 한 언제든지 접근 가능하다.
# 다음은 또 다른 예제다. 2의 제곱열을 반환하는 Proc 객체를 반환하는 예다.

def power_proc_generator
  value = 1
  lambda { value += value }
end

power_proc = power_proc_generator

puts power_proc.call
puts power_proc.call
puts power_proc.call

# 루비는 Proc 객체를 생성하기 위한 또 다른 문법을 제공한다. 이렇게 작성할 수도 있지만,
# lambda { |params| ... }
# 다음과 같이 더 간결하게 작성할 수도 있다.
# -> params { ... }
# 매개 변수는 괄호로 감싸도 되고, 감싸지 않아도 된다. 예를 들면 다음과 같다.

proc1 = -> arg { puts "In proc1 with #{arg}" }
proc2 = -> arg1, arg2 { puts "In proc2 with #{arg1} and #{arg2}" }
proc3 = -> (arg1, arg2) { puts "In proc3 with #{arg1} and #{arg2}" }

proc1.call "ant"
proc2.call "bee", "cat"
proc3.call "dog", "elk"

# -> 형식이 lambda 문법보다 간결하다. 하나 이상의 Proc 객체를 메서드에 넘겨줄 때는 -> 형식이 선호된다.

def my_if(condition, then_clause, else_clause)
  if condition
    then_clause.call
  else
    else_clause.call
  end
end

5.times do |val|
  my_if val < 2,
    -> { puts "#{val} is small" },
    -> { puts "#{val} is big" }
end

# 메서드에 블록을 넘겨주는 게 유용한 이유는 블록 내부의 코드를 언제라도 다시 평가할 수 있다는 점이다. 다음은 while 문을 다시 구현하는 예제다. 반복의 조건을 블록으로 넘겨주기 때문에 반복될 때마다 매번 평가된다.

def my_while(cond, &body)
  while cond.call
    body.call
  end
end

a = 0

my_while -> { a < 3 } do
  puts a
  a += 1
end

# 예전부터 사용되어 오던 문법에서는 블록이 매개 변수를 받으면 블록 시작 위치에 이를 막대 문자(|)를 사용해서 나타냈다. -> 문법을 사용할 때는 블록의 본문에 앞서 매개 변수 리스트를 열거한다. 어느 쪽이건 메서드에 넘기는 것과 마찬가지 매개 변수 리스트를 정의할 수 있다. 메서드와 마찬가지로 기본값, 가변 길이 인자, 키워드 인자, 블록 매개 변수(맨 마지막에 오는 &로 시작하는 매개 변수) 모두 사용할 수 있다. 따라서 메서드와 마찬가지로 다양한 처리를 할 수 있는 블록을 작성할 수 있다. 다음은 블록에서 블록 매개 변수를 사용하는 예제다.

proc1 = lambda do |a, *b, &block|
  puts "a = #{a.inspect}"
  puts "b = #{b.inspect}"
  block.call
end

proc1.call(1, 2, 3, 4) { puts "in block1" }

# 새로운 -> 문법을 사용한 예제다.

proc2 = -> a, *b, &block do
  puts "a = #{a.inspect}"
  puts "b = #{b.inspect}"
  block.call
end

proc2.call(1, 2, 3, 4) { puts "in block2" }
