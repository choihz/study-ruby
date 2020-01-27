# 지금까지 예제에서 봐서 알 수 있듯이 def 키워드로 메서드를 정의한다. 그리고 메서드 이름은 반드시 소문자나 밑줄로 시작해야 하며, 문자, 숫자, 밑줄(_)로 구성된다.
# 메서드 이름 마지막에는 ?, !, =이 올 수 있다. True나 False를 반환하는 메서드(predicate method, 술어 메서드)에는 이름 끝에 ?를 붙이곤 한다.

1.even? # => false
2.even? # => true
1.instance_of?(Fixnum) # => true

# '위험'하거나 수신자의 값을 바꿔버리는 메서드는 이름이 느낌표(!)로 끝나기도 한다. 이는 뱅(bang) 메서드라고 불린다. 예를 들어 String 클래스에는 chop과 chop! 메서드가 있다. 첫 번째 메서드는 변환된 문자열을 반환한다. 두 번째 메서드는 수신자를 바로 변환한다.
# 대입문의 좌변에 올 수 있는 메서드에는 이름 마지막에 등호(=)를 붙인다.

# 오직 ?, !, =만이 메서드 이름 마지막에 허용되는 특수 문자다.
# 이제는 새로운 메서드 이름을 정의하고 매개 변수를 몇 개 더해 보자. 매개 변수를 선언할 때는 괄호 안에 지역 변수를 차례대로 적어주면 된다(메서드의 매개 변수를 둘러싸는 괄호는 필수 사항은 아니다. 이 책에서는 매개 변수가 있을 때는 괄호를 사용하고 그렇지 않으면 생략한다).

def my_new_method(arg1, arg2, arg3) # 세 개의 인자
  # 메서드 본문
end
def my_other_new_method # 인자 없음
  # 메서드 본문
end

# 루비에서는 인자에 기본값을 정해줄 수 있다. 기본값이란 메서드를 호출하면서 인자값이 명시적으로 지정되지 않았을 때 사용할 값을 의미한다. 기본값은 대입 연산자(=)를 이용해서 정의한다. 기본값에 사용되는 표현식에서는 앞서 나온 인자의 값을 참조할 수 있다.

def cool_dude(arg1="Miles", arg2="Coltrane", arg3="Roach")
  "#{arg1}, #{arg2}, #{arg3}."
end

cool_dude # => "Miles, Coltrane, Roach."
cool_dude("Bart") # => "Bart, Coltrane, Roach."
cool_dude("Bart", "Elwood") # => "Bart, Elwood, Roach."
cool_dude("Bart", "Elwood", "Linus") # => "Bart, Elwood, Linus."

# 다음 예제에서는 인자의 기본값에서 앞의 인자를 참조하고 있다.

def surround(word, pad_width=word.length/2)
  "[" * pad_width + word + "]" * pad_width
end

surround("elephant") # => "[[[[elephant]]]]"
surround("fox") # => "[fox]"
surround("fox", 10) # => "[[[[[[[[[[fox]]]]]]]]]]"

# 메서드는 일반적인 루비 표현식들로 이루어진다. 메서드의 반환값은 마지막으로 실행된 표현식의 결괏값이거나 명시적으로 쓰인 return 문의 값이 된다.

# 개수가 정해지지 않은 가변 매개 변수를 전달하고 싶거나 하나의 매개 변수로 여러 개의 매개 변수를 모두 처리하고 싶다면 어떻게 해야 할까? '일반적인' 매개 변수를 모두 적어주고 맨 마지막에 오는 가변 매개 변수의 이름 앞에 별표(*, asterisk)를 붙여 주면 된다. 이를 변수의 가변 길이로 지정한다(splatting)고 표현한다(물체가 빠르게 부딪히는 소리를 나타내는 splatting이라는 표현은 아마 별표(*)가 빠르게 움직이는 차 전면에 부딪히는 벌레 같은 것처럼 보이는 데서 유래했을 것이다).

def varargs(arg1, *rest)
  "arg1=#{arg1}. rest=#{rest.inspect}"
end

varargs("one") # => arg1=one. rest=[]
varargs("one", "two") # => arg1=one. rest=["two"]
varargs("one", "two", "three") # => arg1=one. rest=["two", "three"]

# 앞선 예제에서 첫 번째 매개 변수는 평소처럼 메서드의 첫 번째 매개 변수에 대입되었다. 하지만 두 번째 매개 변수에는 별표가 붙어 있기 때문에 남은 매개 변수 모두를 새로운 Array 객체에 저장하여 매개 변수에 대입하였다.
# 이러한 가변 길이 매개 변수는 메서드에서는 직접 사용하지는 않지만 상위 클래스에서 같은 이름을 가지는 메서드를 호출하고자 하는 경우에 사용되기도 한다(다음 예제에서 super를 매개 변수 없이 호출하고 있다는 점에 주목하자. 이는 상위 클래스에 있는 같은 이름의 메서드를 호출하라는 의미를 가진다. 또한 이때 현재 메서드에 넘겨진 모든 매개 변수를 호출하는 메서드에 넘겨준다).

class Parent
end

class Child < Parent
  def do_something(*not_used)
    # 메서드 본문
    super
  end
end

# 이때 매개 변수 이름을 생략하고 *만을 사용해도 같은 의미다.

class Child < Parent
  def do_something(*)
    # 메서드 본문
    super
  end
end

# 가변 길이 매개 변수는 매개 변수 리스트의 어디에나 올 수 있다. 따라서 다음 예제와 같이 사용할 수도 있다.

def split_apart(first, *splat, last)
  puts "first: #{first.inspect}, splat: #{splat.inspect}, " +
    "last: #{last.inspect}"
end

split_apart(1, 2)
split_apart(1, 2, 3)
split_apart(1, 2, 3, 4)

# 맨 처음 매개 변수와 마지막 매개 변수에만 관심이 있다면 앞의 메서드를 다음과 같이 정의하는 것도 가능하다.

def split_apart(first, *, last)
end

# 둘 이상의 가변 길이 매개 변수는 모호하므로 이러한 매개 변수는 반드시 메서드에 하나만 정의되어야 한다. 또한 가변 길이 매개 변수에는 기본값을 지정할 수 없다. 가변 길이 변수에는 항상 나머지 변수들에 대한 대입이 끝나고 남은 변수들이 대입된다.

# 메서드를 호출할 때 이에 블록을 결합시킬 수 있다. 일반적으로 결합된 블록은 메서드 안에서 yield를 사용해 호출할 수 있다.

def double(p1)
  yield(p1 * 2)
end

double(3) {|val| "I got #{val}"} # => "I got 6"
double("tom") {|val| "Then I got #{val}"} # => "Then I got tomtom"

# 하지만 마지막 매개 변수 앞에 앰퍼샌드(&)를 붙여준다면 주어진 블록이 Proc 객체로 변환되어, 이 객체를 마지막 매개 변수(블록 매개 변수)에 대입한다. 이를 통해 이 블록을 나중에 사용할 수도 있다.

class TaxCalculator
  def initialize(name, &block)
    @name, @block = name, block
  end
  def get_tax(amount)
    "#@name on #{amount} = #{@block.call(amount)}"
  end
end

tc = TaxCalculator.new("Sales tax") {|amt| amt * 0.075}

puts tc.get_tax(100) # => "Sales tax on 100 = 7.5"
puts tc.get_tax(250) # => "Sales tax on 250 = 18.75"

# 메서드를 호출할 때는 수신자의 이름을 써 주고 그 뒤에 메서드 이름을 쓰고, 필요한 경우 몇 개의 매개 변수를 써 준다. 마지막으로 맨 뒤에 블록이 올 수 있다. 다음 예제는 메서드의 수신자와 매개 변수, 블록이 모두 있는 경우다.

# connection.download_mp3("jitterbug") {|p| show_progress(p)}

# 이 예제에서 connection 객체는 수신자가 되고 download_mp3는 메서드의 이름이 된다. 'jitterbug'는 매개 변수이며 중괄호로 감싸져 있는 코드가 메서드 호출에 결합되는 블록이 된다. 이 메서드가 호출되는 동안에 루비는 self를 수신자로 설정하며 이 객체에 대해 메서드를 호출한다. 클래스나 모듈의 메서드를 호출할 때, 수신자 위치에 클래스 이름이나 모듈 이름을 적어주면 된다.

File.size("testfile")
Math.sin(Math::PI/4)

# 수신자를 생략하면, 수신자는 기본값인 현재 객체를 나타내는 self가 된다.

class InvoiceWriter
  def initialize(order)
    @order = order
  end
  def write_on(output)
    write_header_on(output) # 현재 객체를 수신자로 호출한다.
    write_body_on(output)
    write_totals_on(output)
  end
  def write_header_on(output)
    # ...
  end
  def write_body_on(output)
    # ...
  end
  def write_totals_on(output)
    # ...
  end
end

# 수신자를 생략했을 때의 처리 방식은 루비가 private 메서드를 다루는 것과 같다. private 메서드를 호출할 때는 수신자를 지정할 수 없으므로 그 메서드는 현재 객체에서 호출할 수 있는 것이어야 한다. 앞선 예제에서 헬퍼 메서드를 private으로 설정하는 것이 좋다. 이 메서드는 InvoiceWriter 클래스 외부에서 호출되어서는 안 되기 때문이다.

class InvoiceWriter
  def initialize(order)
    @order = order
  end
  def write_on(output)
    write_header_on(output)
    write_body_on(output)
    write_totals_on(output)
  end

private
  
  def write_header_on(output)
    # ...
  end
  def write_body_on(output)
    # ...
  end
  def write_totals_on(output)
    # ...
  end
end

# 메서드 이름 다음에는 매개 변수가 따라온다. 모호한 표현이 아니라면, 메서드 호출 시에 매개 변수 리스트를 둘러싼 괄호를 생략해도 된다. 하지만 간단한 케이스를 제외하고는 이 방식을 추천하지 않는다. 사소한 문제로 말썽이 생길 수도 있기 때문이다. 우리가 추천하는 규칙은 간단하다. 뭔가 망설임이 생긴다면 반드시 괄호를 사용하라.

# 적절한 객체 obj가 있다고 할 때,
# a = obj.hash # 두 표현은
# a = obj.hash() # 같다

# obj.some_method "Arg1", arg2, arg3 # 두 표현은
# obj.some_method("Arg1", arg2, arg3) # 같다

# 루비 이전 버전에서는 메서드 이름과 '(' 사이에 공백을 허용하고 있어서 문제가 발생하곤 했다. 이런 문법은 분석하기 어렵다. 이 괄호가 매개 변수의 시작을 의미할까? 아니면 다른 표현식의 시작을 의미할까? 루비 1.8부터는 메서드 이름과 괄호 사이에 공백을 넣으면 경고 메시지를 보게 될 것이다.

# (반드시 반환값을 사용해야 한다는 규칙은 없지만) 호출된 모든 메서드는 값을 반환한다. 메서드의 반환값은 메서드 실행 중 마지막으로 실행된 표현식의 결괏값이다.

def meth_one
  "one"
end
puts meth_one

def meth_two(arg)
  case
  when arg > 0 then "positive"
  when arg < 0 then "negative"
  else "zero"
  end
end
puts meth_two(23)
puts meth_two(0)

# 루비에도 물론 현재 수행 중인 메서드를 빠져나가는 return 문이 있다. 이 경우에는 return 문의 매개 변수나 매개 변수들이 반환값이 된다. 하지만 앞선 예제에서 알 수 있듯이 return 문을 쓸 필요가 없다면 생략하는 것이 루비식 표현이다.
# 다음에서는 메서드 안에서 return 문을 명시적으로 사용해 반복문을 빠져나가는 예제를 살펴본다.

def meth_three
  100.times do |num|
    square = num * num
    return num, square if square > 1000
  end
end
puts meth_three

# 마지막 예제에서 볼 수 있듯이 return의 매개 변수로 여러 개의 값을 동시에 넘기면 메서드는 배열의 형태로 값을 반환한다. 배열로 반환된 값을 모으기 위해서는 병렬 대입문(parallel assignment)을 이용할 수 있다.

num, square = meth_three
puts num
puts square

# 앞서 이야기한 것처럼 메서드 선언부에서 매개 변수 이름 앞에 별표(*)를 붙이면 메서드 호출에 사용된 여러 개의 인자가 하나의 배열로 된 매개 변수로 합쳐지게 된다. 물론 이 반대의 경우도 성립한다.
# 역으로 메서드를 호출할 때, 컬렉션 객체나 열거자를 확장해서 구성 원소가 각각의 매개 변수에 대응되도록 할 수 있다. 이렇게 하려면 별표(*)를 배열 매개 변수 앞쪽에 붙여주면 된다.

def five(a, b, c, d, e)
  "I was passed #{a} #{b} #{c} #{d} #{e}"
end

puts five(1, 2, 3, 4, 5)
puts five(1, 2, 3, *['a', 'b'])
puts five(*['a', 'b'], 1, 2, 3)
puts five(*(10..14))
puts five(*[1, 2], 3, *(4..5))

# 루비 1.9부터 가변 길이 매개 변수는 매개 변수 목록의 어디에나 위치할 수 있게 되었기 때문에, 일반적인 매개 변수와 섞어서 사용할 수 있다.

# 우리는 이미 메서드 호출에 블록을 결합하는 방법을 알고 있다.

# collection.each do |member|
#   # ...
# end

# 일반적인 경우에는 이 정도의 기능만으로 충분하다. 예를 들면 if 문이나 while 문 다음에 코드를 쓰는 것과 같은 방식으로 메서드에 고정된 코드 블록을 결합시키면 된다. 하지만 때로는 더 유연함을 필요로 하는 경우도 있다. 계산법을 가르친다고 해 보자. 학생들은 n-plus 테이블과 n-times 테이블이 필요할 것이다. 학생들이 2-times 테이블을 원하면 2, 4, 6, 8...을 만들어 반환해 주어야 한다(다음 코드는 입력에 대한 오류 검사를 하지 않는다).

print "(t)imes or (p)lus: "
operator = gets
print "number: "
number = Integer(gets)

if operator =~ /^t/
  puts ((1..10).collect {|n| n * number}.join(", "))
else
  puts ((1..10).collect {|n| n + number}.join(", "))
end

# 앞의 코드는 잘 동작하지만 if 문에 비슷한 코드가 반복되어서 별로 깔끔해 보이지 않는다. if 문에서 계산하는 부분만을 빼낼 수 있다면 더 깔끔한 코드를 작성할 수 있을 것이다.

print "(t)imes or (p)lus: "
operator = gets
print "number: "
number = Integer(gets)

if operator =~ /^t/
  calc = lambda {|n| n * number}
else
  calc = lambda {|n| n + number}
end

puts ((1..10).collect(&calc).join(", "))

# 메서드의 마지막 매개 변수 앞에 앰퍼샌드(&)가 붙어 있다면, 루비는 이 매개 변수를 Proc 객체로 간주한다. 이 경우 일단 Proc 객체를 매개 변수 리스트에서 빼내서 이를 블록으로 변환한 다음 메서드에 결합하는 식으로 처리한다.

# 사람들은 해시를 통해 선택적인 이름 있는 인자를 메서드에 넘기는 방법을 자주 사용한다. 예를 들어 MP3 플레이리스트에 검색 기능을 추가한다고 해 보자.

class SongList
  def search(field, params)
    # ...
  end
end

list = SongList.new
list.search(:titles, {genre: "jazz", duration_less_than: 270})

# 첫 번째 인자는 검색을 통해 반환받고 싶은 값이다. 두 번째 이름은 검색 매개 변수들을 모은 해시 리터럴이다(해시에서 심벌을 키로 사용하고 있음에 주목하자. 이는 루비 라이브러리와 프레임워크에서 사용하는 관습이다). 해시를 사용해서 마치 각각의 키워드인 것처럼 사용할 수 있다. 앞선 예제에서는 장르가 'jazz'이며 4분 30초보다 짧은 곡을 찾는다.
# 하지만 이러한 방법은 조금 이상해 보이고, 중괄호를 사용하고 있기 때문에 메서드에 블록이 결합되어 있는 것처럼 보이기도 한다. 루비는 이에 대한 축약 표현을 제공한다. 이러한 축약 표현은 매개 변수 목록에서 key => value 쌍들이 일반적인 매개 변수 뒤에 위치하고, 별표(*)가 붙은 매개 변수나 블록 매개 변수 앞에 온다면 사용할 수 있다. 이러한 모든 키, 값 쌍들은 하나의 해시로 모아져 하나의 매개 변수로 메서드에 넘겨지게 된다. 따라서 더 이상 중괄호는 필요하지 않다.

list.search(:titles, genre: "jazz", duration_less_than: 270)

# search 메서드의 내부를 좀 더 들여다보자. 이는 필드 이름과 옵션들을 담은 해시를 받는다. 기본 설정을 길이 120초로 하고, 잘못된 옵션이 없는지 검증하고자 한다. 루비 2.0 이전에는 다음과 같은 코드였을 것이다.

def search(field, options)
  options = {duration: 120}.merge(options)
  if options.has_key?(:duration)
    duration = options[:duration]
    options.delete(:duration)
  end
  if options.has_key?(:genre)
    genre = options[:genre]
    options.delete(:genre)
  end
  fail "Invalid options: #{options.keys.join(', ')}" unless options.empty?
  # 나머지 구현
end

# 시간이 충분하다면 결국에 해시 매개 변수를 추출하고 검증하는 메서드를 작성했을 것이다.
# 루비 2가 이런 상황을 해결해 준다. 이제 메서드에서 직접 키워드 매개 변수를 정의할 수 있다. 여전히 해시를 매개 변수로 넘겨줄 수 있지만, 이제 루비가 직접 해시를 매개 변수 목록에 대입한다. 또한 넘겨지지 않은 매개 변수가 있는지 직접 검증도 해 준다.

def search(field, genre: nil, duration: 120)
  p [field, genre, duration]
end

search(:title)
search(:title, duration: 432)
search(:title, duration: 432, genre: "jazz")

# 올바르지 않은 옵션을 넘기면 루비는 에러를 발생시킨다.

def search(field, genre: nil, duration: 120)
  p [field, genre, duration]
end

search(:title, duraton: 432)

# 또한 매개 변수 목록에 없는 해시로 넘어온 매개 변수들을 두 개의 별표(**)를 이름에 붙여 매개 변수로 받을 수도 있다.

def search(field, genre: nil, duration: 120, **rest)
  p [field, genre, duration, rest]
end

search(:title, duration: 432, stars: 3, genre: "jazz", tempo: "slow")

# 또한 이를 증명하기 위해선 매개 변수를 담은 해시를 넘겨서 메서드를 호출해 보면 된다.

options = {duration: 432, stars: 3, genre: "jazz", tempo: "slow"}
search(:title, options)

# 잘 짠 루비 프로그램은 일반적으로 작은 크기의 많은 메서드를 포함한다. 따라서 메서드를 정의하고 호출할 때 사용할 수 있는 여러 방법에 익숙해지는 것은 많은 도움을 준다.
