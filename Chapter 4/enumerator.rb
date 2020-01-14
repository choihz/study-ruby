# 루비가 반복자에 대해 갖고 있는 접근법을 C++, 자바 같은 여타 언어와 비교하는 데 한 문단 정도를 할애하고자 한다. 루비에서는 반복자가 컬렉션의 내부에 있다. 즉 반복자는 단순히 메서드이며 다른 메서드와 다를 게 없고, 새로운 값을 위해 매번 yield를 호출한다. 반복자를 이용하는 주체는 바로 메서드에 결합된 블록이다.
# 다른 언어에서는 컬렉션이 자신의 반복자를 포함하지 않는다. 대신 반복 상태를 가지고 있는 외부 반복자 헬퍼 객체(예를 들어 자바의 Iterator 인터페이스에서 파생된)를 만들어 사용한다. 다른 경우와 마찬가지로 이 경우에도 루비는 투명한(transparent) 언어다. 루비 프로그램을 작성할 때는 하고자 하는 일에만 집중하면 되고, 언어 자체적으로 지원하는 발판 코드를 작성하느라 고민할 필요가 없다.
# 루비의 내부 반복자가 항상 최상의 해결책은 아니라는 것에 대해서도 한 문단을 할애하고자 한다. 별로 좋지 않은 경우가 바로 반복자를 단독 객체로 사용하고 싶을 때다(예를 들어 반복자를 메서드에 넘겨 이 메서드 내에서 반복자가 반환하는 각 값에 접근하려고 할 때). 루비의 내부 반복자를 사용해서 두 개 이상의 컬렉션을 병렬적으로 탐색하는 것도 쉽지 않다.
# 다행히도 루비의 내장 Enumerator 클래스는 이러한 경우에 사용할 수 있도록 외부 반복자를 제공한다.
# 배열이나 해시에 대해 to_enum 메서드를 호출하는 것만으로 Enumerator 객체를 생성할 수 있다(enum_for도 같은 메서드다).

a = [ 1, 3, "cat" ]
h = { dog: "canine", fox: "vulpine" }

# 열거자를 생성한다.
enum_a = a.to_enum
enum_h = h.to_enum

enum_a.next # => 1
enum_h.next # => [:dog, "canine"]
enum_a.next # => 3
enum_h.next # => [:fox, "vulpine"]

# 대부분의 내부 반복자와 메서드(즉, 연속적으로 컬렉션의 값에 대해 yield를 통해 블록을 실행하는 메서드)들은 블록 없이 호출하면 Enumerator 객체를 반환한다.

a = [ 1, 3, "cat" ]

enum_a = a.each # 내부 반복자를 사용해 외부 반복자를 생성

enum_a.next # => 1
enum_a.next # => 3

# 루비에는 블록을 그저 반복적으로 실행하기만 하는 loop라는 메서드가 있다. 일반적으로 이 loop를 사용할 때는 특정한 조건에 의해 반복이 정지되도록 한다. 하지만 loop를 Enumerator와 함께 사용하면 좀 더 편리하게 사용할 수 있다. loop 안에서 열거자 객체를 전부 반복하고 loop는 깔끔하게 종료된다. 다음은 이러한 특징을 활용한 예제다. 세 개의 요소를 가지고 있는 열거자 객체의 모든 값을 반복하고 나면(즉 모든 값을 읽어 들이고 나면) 루프는 자동으로 종료된다.

short_enum = [1, 2, 3].to_enum
long_enum = ('a'..'z').to_enum

loop do
  puts "#{short_enum.next} - #{long_enum.next}"
end

# 열거자는 일반적으로 (각 요소를 반복해서) 실행 가능한 코드를 인자로 받아들여 객체로 변환한다. 이를 통해 일반적인 반복으로는 작성하기 어려운 처리도 열거자를 통해 처리할 수 있다.
# 예를 들어 Enumerable 모듈에는 each_with_index 메서드가 정의되어 있다. 이는 호스트 클래스의 each 메서드를 호출하며, 컬렉션의 다음 값과 함께 위치 정보를 같이 반환한다.

result = []
['a', 'b', 'c'].each_with_index {|item, index| result << [item, index]}
puts result

# 다른 반복자 메서드에서도 이 인덱스를 사용하고자 하면 어떻게 해야 할까? 예를 들어 문자열의 각 문자를 인덱스와 함께 반복하고 싶다고 해 보자. 하지만 String 클래스에 each_char_with_index와 같은 메서드는 없다.
# 열거자가 이 문제를 해결해 준다. 문자열 객체의 each_char 메서드는 블록을 넘기지 않으면 열거자 객체를 반환한다. 이 열거자 객체에 대해 each_with_index를 호출하는 방법을 사용할 수 있다.

result = []
"cat".each_char.each_with_index {|item, index| result << [item, index]}
puts result

# 이는 열거자를 활용하는 기본적인 방법이다. 마츠는 이에 착안해 with_index라는 좀 더 간결한 해결책을 준비해 두었다.

result = []
"cat".each_char.with_index {|item, index| result << [item, index]}
puts result

# 물론 Enumerator 객체를 좀 더 명시적으로 생성할 수도 있다. 다음 예제에서는 each_char 메서드를 호출한 결과를 Enumerator 객체로 생성한다. 이 열거자 객체에 to_a를 호출해 반복 처리한 결과를 얻을 수 있다.

enum = "cat".enum_for(:each_char)
enum.to_a # => ["c", "a", "t"]

# 열거자의 베이스가 되는 메서드가 매개 변수를 받는다면 enum_for에 같이 넘겨줄 수도 있다.

enum_in_threes = (1..10).enum_for(:each_slice, 3)
enum_in_threes.to_a # => [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10]]

# 이미 존재하는 컬렉션으로부터 열거자를 생성할 수도 있지만, 명시적으로 블록을 넘겨 열거자를 생성할 수도 있다. 블록의 코드는 열거자 객체가 프로그램에 새로운 값을 생성해서 전달할 때 필요하다. 하지만 이 블록이 단순히 위에서 아래로 실행되지는 않는다.
# 블록은 선형적으로 실행되는 대신 프로그램의 나머지 부분과 병렬로 실행된다. 블록은 위에서부터 시작하지만 블록이 특정한 값을 yield하는 시점에서 실행을 멈춘다. 프로그램에서 새로운 값을 필요로 할 때 다시 이를 호출하면 이전에 블록에서 멈춘 부분부터 다시 다음 값을 yield할 때까지 프로그램을 실행한다. 이를 통해 무한히 값을 생성할 수 있는 열거자를 생성할 수 있다(물론 이외에도 다양한 일을 할 수 있다).

triangular_numbers = Enumerator.new do |yielder|
  number = 0
  count = 1
  loop do
    number += count
    count += 1
    yielder.yield number
  end
end

5.times { print triangular_numbers.next, " " }
puts

# 열거자 객체도 열거 가능(enumerable)하다. 이 말은 열거 가능한 객체에서 사용 가능한 메서드는 열거자 객체에서도 사용 가능하다는 의미다. 따라서 first와 같은 Enumerable의 메서드 역시 사용 가능하다.

triangular_numbers = Enumerator.new do |yielder|
  number = 0
  count = 1
  loop do
    number += count
    count += 1
    yielder.yield number
  end
end

p triangular_numbers.first(5)

# 블록이 주로 반복자에서 사용되기는 하지만 다른 용도로 사용되기도 한다. 여기서 몇 가지를 살펴보자.
# 먼저 트랜잭션 제어 하에서 동작해야만 하는 코드를 작성해야 할 때 블록을 사용할 수 있다. 예를 들어 파일을 열고 그 내용으로 어떤 작업을 하고 이 작업을 마치면 이 파일이 닫힌다는 사실을 확신하고 싶다고 하자. 물론 이것은 지금까지의 방식으로 해결할 수도 있지만 블록을 사용하는 방식은 좀 더 단순하다(더욱이 에러를 줄일 수 있다는 이점을 추가적으로 얻을 수 있다). 다음 예제는 예외 처리를 포함하지 않는 간단한 구현을 보여준다.

class File
  def self.open_and_process(*args)
    f = File.open(*args)
    yield f
    f.close()
  end
end

File.open_and_process("testfile", "r") do |file|
  while line = file.gets
    puts line
  end
end

# open_and_process는 클래스 메서드다. 특정한 파일 객체에 상관없이 호출할 수 있다. 이 메서드가 일반적인 File.open 메서드와 똑같은 매개 변수를 받는다면 편리할 것이다. 하지만 File.open 메서드는 어떤 매개 변수가 무엇인지는 신경 쓰지 않아도 된다. 이를 위해 메서드 정의 부분에 매개 변수를 *args라고 쓰기만 하면 된다. 이것이 뜻하는 바는 "실제로 메서드에서 넘겨받는 매개 변수를 모아서 배열로 만들고 args라고 이름 붙여라"다. 그다음에는 File.open을 호출해서 *args를 매개 변수로 넘긴다. 이는 배열을 다시 펼쳐서 요소 각각을 매개 변수로 넘긴다. 따라서 결과적으로 open_and_process 메서드가 받은 매개 변수를 투명하게 File.open으로 넘겨주게 된다.
# 파일을 열었다면 이제 open_and_process 메서드는 yield를 호출하여 방금 연 파일 객체를 블록 객체에 넘겨준다. 그리고 블록 실행이 종료되면 파일을 닫는다. 이렇게 함으로써 열린 파일의 핸들을 닫아야 하는 책임이 파일 객체의 사용자로부터 파일 객체 자체로 넘어가게 된다.
# 파일 객체가 스스로 자신의 생명 주기를 관리하는 이 기법은 워낙 유용한 것이라서 루비의 File 클래스에서 직접 이런 기능을 지원한다. File.open 메서드 호출에 블록을 결합하면 그 블록이 파일 객체와 함께 실행될 것이고, 블록 실행을 마치면 파일 객체는 자동으로 닫힌다.
# 여기서 흥미로운 점은 File.open 메서드가 서로 다른 두 가지 작동법을 갖고 있다는 점이다. 블록과 함께 호출할 때는 블록을 실행하고 파일을 닫는다. 하지만 블록이 없으면 파일 객체를 반환할 뿐이다. 이는 block_given? 메서드를 사용해서 구현할 수 있는데, 이 메서드는 현재 메서드에 블록이 결합되어 있다면 true를 반환한다. 이를 이용해 다음과 같이 표준 File.open 메서드를 비슷하게 구현할 수 있다(예외 처리는 무시한다).

class File
  def self.my_open(*args)
    result = file = File.new(*args)
    # 블록이 있으면 파일을 넘기고 실행을 마치면 파일을 닫는다
    if block_given?
      result = yield file
      file.close
    end
    result
  end
end

# 이 예제에는 한 가지 문제가 있다. 자원의 열고 닫음을 블록에 맡긴 지금까지의 예제에서 우리는 예외 처리를 고려하지 않았다. 메서드를 제대로 구현하고자 한다면 파일로 무언가를 처리하던 중 갑자기 문제가 발생하더라도 파일이 닫힌다는 사실을 보장해야만 한다. 이를 위해 예외 처리가 필요하다. 이는 10장에서 다룬다.
