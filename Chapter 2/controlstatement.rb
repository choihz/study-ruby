# 루비는 if 문과 while 반복문 같은 보편적인 제어문을 모두 지원한다.
# 루비에서는 중괄호 대신 제어문의 마지막을 나타내기 위해 end 키워드를 사용한다.

today = Time.now

if today.saturday?
  puts "Do chores around the house"
elsif today.sunday?
  puts "Relax"
else
  puts "Go to work"
end

# 마찬가지로 while 문도 end로 끝이 난다.

num_pallets = 0
weight = 0
while weight < 100 and num_pallets <= 5
  pallet = next_pallet()
  weight += pallet.weight
  num_pallets += 1
end

# 루비에서 대부분의 구문이 값을 반환하므로, 제어문의 조건절에 이런 구문을 직접 써 줘도 된다.
# 예를 들어 gets 메서드는 표준 입력 스트림의 다음 줄을 반환하는데, 파일의 끝에 도달한 경우 특별히 nil을 반환한다. 루비는 조건문에서 nil을 거짓값으로 간주하기 때문에, 다음 코드가 파일의 모든 줄을 처리할 수 있다.

while line = gets
  puts line.downcase
end

# 예제에서 첫 줄의 대입문은 line 변수에 다음 줄의 텍스트나 nil을 넣는다. 그다음 while 문이 대입문의 결괏값을 검사하여, 이 값이 nil이 되면 루프를 끝낸다.
# if나 while 문 안의 내용이 코드 한 줄이라면, 이를 짧게 줄여 쓸 수 있는 유용한 방법이 있다. 바로 구문 변경자(statement modifier)다. 실행될 코드를 쓰고, 그 뒤에 if나 while과 조건문을 써주면 된다.

if radiation > 3000
  puts "Danger, Will Robinson"
end

# 앞선 예제를 한 줄로 줄여 쓰면 다음과 같다.

puts "Danger, Will Robinson" if radiation > 3000

# while 문에도 사용할 수 있다.

square = 4
while square < 1000
  square = square * square
end

# 여기에 구문 변경자를 사용하면 다음과 같이 작성할 수 있다.

square = 4
square = square * square while square < 100
