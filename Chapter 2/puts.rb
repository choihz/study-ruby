puts "gin.joint".length # 문자열의 길이를 요청한다.
puts "Rick".index("c") # 문자열에서 알파벳 c의 위치를 찾을 것을 요청한다.
puts 42.even? # 42가 짝수인지 질문한다(물음표는 even? 메서드의 일부다).
puts sam.play(song) # sam 객체에 song을 play하도록 메서드를 호출한다.

# puts는 루비 표준 메서드이며, 인자들을 콘솔에 출력하고 마지막에 줄바꿈을 추가한다.
# 메서드 호출은 마침표 문자로 구분되는데 앞부분은 수신자(receiver)이고 뒷부분은 실행될 메서드다.

# 자바에서 어떤 숫자의 절댓값을 구하려면
# num = Math.abs(num)
# 루비에서는 숫자 객체가 절댓값을 구하는 기능을 가지고 있다.
num = -1234 # => -1234
positive = num.abs # => 1234

# C에서 문자열의 길이를 얻기 위해서는
# strlen(name)
# 루비에서는
name = "choihz"
puts name.length
