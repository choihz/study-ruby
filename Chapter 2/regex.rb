# 정규 표현식은 간단히 말해 문자열에 매치(match)되는 패턴을 기술하는 방법이다. 루비에서는 슬래시 사이에 패턴을 적으면 정규 표현식을 의미한다(/pattern/).
# 루비이기 때문에 정규 표현식 또한 객체이고, 사용법도 다른 객체와 별반 다르지 않다.
# 예를 들어 Perl이나 Python을 포함하는 문자열을 찾는 패턴을 만들기 위해서는 다음과 같은 정규 표현식을 사용한다.

/Perl|Python/

# 슬래시 문자로 패턴임을 표시했고, 찾고자 하는 두 개의 문자열을 파이프(|)를 이용하여 나열했다.
# 파이프는 '오른쪽의 값이거나 왼쪽의 값'이라는 의미로 위의 경우에는 Perl이나 Python 중 하나가 된다.
# 그리고 산수 계산에서처럼 패턴을 괄호로 묶어줄 수도 있다.

/P(erl|ython)/

# 패턴에서는 문자 반복을 표현할 수도 있다. /ab+c/는 a가 하나 오고, 그 뒤에 1개 이상의 b가 오고, 이어서 c가 오는 문자열을 나타낸다.
# 이 패턴에서 더하기를 별표로 바꾼 /ab*c/는 a가 하나 오고, b가 없거나 여러 개, 이어서 c 하나가 오는 문자열을 나타낸다.

# 문자 그룹 중 하나와 매치하는 것도 가능하다. 가장 많이 쓰이는 것으로 \s는 공백 문자(space, tab, newline 등)를 나타내고, \d는 숫자, \w는 일반적인 단어에서 쓰이는 문자를 나타낸다. 그리고 마침표(.)는 아무 글자나 한 글자를 의미한다.

/\d\d:\d\d:\d\d/ # 12:34:56 형태의 시간
/Perl.*Python/ # Perl, 0개 이상의 문자들, 그리고 Python
/Perl Python/ # Perl, 공백, Python
/Perl *Python/ # Perl, 0개 이상의 공백, Python
/Perl +Python/ # Perl, 1개 이상의 공백, Python
/Perl\s+Python/ # Perl, 1개 이상의 공백 문자, Python
/Ruby (Perl|Python)/ # Ruby, 공백, 그리고 Perl이나 Python

# 매치 연산자 =~는 특정 문자열이 정규 표현식과 매치되는지 검사하는 데 사용한다. 이 연산자는 문자열에서 패턴이 발견되면 발견된 첫 위치를 반환하고, 그렇지 않으면 nil을 반환한다. 이 말은 정규 표현식도 if 문이나 while 문 등에서 조건식으로 사용할 수 있다는 의미다.
# 예를 들어 다음 예제는 문자열이 Perl이나 Python을 포함하고 있으면 메시지를 출력한다.

line = gets
if line =~ /Perl|Python/
  puts "Scripting language mentioned: #{line}"
end

# 루비의 치환 메서드를 이용하면 정규 표현식으로 찾아낸 문자열의 일부를 다른 문자열로 바꿀 수 있다.

line =  gets
newline = line.sub(/Perl/, 'Ruby') # 처음 나오는 'Perl'을 'Ruby'로 바꾼다.
newerline = newline.gsub(/Python/, 'Ruby') # 모든 'Python'을 'Ruby'로 바꾼다.

# 문자열에서 Perl과 Python을 모두 Ruby로 바꾸려면 다음과 같이 쓰면 된다.

line = gets
newline = line.gsub(/Perl|Python/, 'Ruby')
