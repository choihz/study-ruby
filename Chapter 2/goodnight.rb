def say_goodnight(name)
  result = "Good night, " + name
  return result
end

# 잠잘 시간입니다
puts say_goodnight("John-Boy")
puts say_goodnight("Mary-Ellen")

# 메서드 정의에는 def 키워드를 사용한다.
# def 다음에 메서드 이름을 쓰고, 괄호로 싸인 메서드 매개 변수를 쓴다(괄호는 생략될 수 있다).
# 루비에서는 중괄호를 사용하지 않는 대신 메서드 끝 부분에 end 키워드를 사용한다.

# 루비에서 다음 두 표현식이 뜻하는 바는 같다.

puts say_goodnight("John")
puts(say_goodnight("John"))

# 아주 간단한 경우를 제외하고는 괄호를 사용할 것을 권장한다.

# 문자열 객체를 만드는 방법 중 가장 일반적인 것은 문자열 리터럴을 사용하는 것이다.
# 문자열 리터럴이란 작은따옴표나 큰따옴표로 묶인 문자의 시퀀스를 말한다.
# 작은따옴표를 사용할 때 루비는 이 문자열을 거의 그대로 사용하지만, 큰따옴표를 사용하면 루비는 더 많은 처리를 한다.
# - \n은 줄바꿈 문자로 변경된다.
# - 문자열 안에 #{expression} 같은 형태가 있으면 이는expression을 평가한 값으로 반환된다.

def say_goodmorning(name)
  result = "Good morning, #{name}"
  return result
end
puts say_goodmorning('Pa')

# 루비가 문자열 객체를 생성할 때, 변수 name의 현재 값을 찾아서 그 값을 문자열에 삽입해 주는 것이다. #{...} 안에서 복잡한 표현식을 사용할 수도 있다.
# 다음 예제에서는 매개 변수의 첫 번째 글자를 대문자로 바꿔서 출력하기 위해 capitalize 메서드(모든 문자열 객체가 갖고 있는 메서드)를 호출하고 있다.

def say_goodevening(name)
  result = "Good evening, #{name.capitalize}"
  return result
end
puts say_goodevening('uncle')

# 루비 메서드에서 반환하는 값은 마지막으로 실행된 표현식의 결괏값이다.
# 이를 이용하면 앞선 예제에서 임시 변수와 return 문을 함께 제거할 수 있다.

def hello(name)
  "Hello, #{name.capitalize}"
end
puts hello('ma')

# 루비에서 지역 변수, 메서드 매개 변수, 메서드 이름은 모두 소문자나 밑줄(_)로 시작해야 한다.
# 전역 변수는 달러 표시($)로 시작한다.
# 인스턴스 변수는 앳(@)으로 시작한다.
# 클래스 변수는 두 개의 앳 표시(@@)로 시작한다.
# 클래스 이름, 모듈 이름, 상수는 대문자로 시작한다.
# 인스턴스 변수는 단어 사이에 밑줄을 넣어서 구분하고(instance_var), 클래스 이름의 경우에는 MixedCase와 같이 각 단어의 첫 글자를 대문자로 한다. 또한 메서드 이름은 ?, !, = 기호로 끝날 수 있다.
