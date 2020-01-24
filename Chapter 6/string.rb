# 루비 문자열은 간단히 말하면 문자열의 시퀀스다. 보통 출력 가능한 문자를 저장하지만, 반드시 그래야만 하는 것은 아니다. 문자열에는 이진(binary) 데이터를 저장할 수도 있다. 문자열은 String 클래스의 객체다. 문자열은 주로 문자열 리터럴을 통해 생성된다. 문자열 리터럴은 구분 문자(delimiter) 사이에 문자 시퀀스를 쓰는 것이다. 하지만 이진 데이터는 다른 문자열처럼 프로그램의 소스 안에 표현하기가 어렵기 때문에 문자열 리터럴에는 이스케이프 시퀀스를 함께 사용할 수 있도록 하였다. 그리고 문자열 리터럴 각각은 프로그램이 컴파일될 때 해당 이진 값으로 변환된다. 사용한 문자열 구분 문자에 따라 이런 변환이 일어나는 정도도 다르다. 작은따옴표로 묶인 문자열에서는 역슬래시 두 개를 나란히 쓰면 역슬래시 하나로 변환되고, 역슬래시 다음에 작은따옴표를 쓰면 작은따옴표 하나로 변환된다.

'escape using "\\"' # => escape using "\"
'That\'s right' # => That's right

# 큰따옴표로 묶인 문자열은 더 많은 이스케이프 시퀀스를 지원한다. 그중 가장 일반적인 것이 바로 줄 바꿈을 나타내는 \n이다. 게다가 #{ expr }과 같은 식으로 쓰면 루비 코드의 결과를 문자열로 변환해 준다. 만약 #{} 안의 표현식이 전역 변수나 클래스 변수, 인스턴스 변수라면 중괄호를 생략해도 된다.

"Seconds/day: #{24*60*60}" # => Seconds/day: 86400
"#{'Ho! '*3}Merry Christmas!" # => Ho! Ho! Ho! Merry Christmas!
"Safe level is #$SAFE" # => Safe level is 0

# 삽입되는 코드는 단순한 표현식뿐 아니라 한 줄 이상의 문장들이어도 무방하다.

puts "now is #{ def the(a)
                  'the ' + a
                end
                the('time')
              } for all bad coders..."

# 이 외에도 문자열을 만드는 스트링 리터럴은 %q, %Q, 히어(here) 도큐먼트 이렇게 세 가지가 더 있다. %q와 %Q는 각각 작은따옴표와 큰따옴표에 대응된다.

%q/general single-quoted string/ # => general single-quoted string
%Q!general double-quoted string! # => general double-quoted string
%Q{Seconds/day: #{24*60*60}} # => Seconds/day: 86400

# 사실 Q는 생략할 수 있다.

%!general double-quoted string! # => general double-quoted string
%{Seconds/day: #{24*60*60}} # => Seconds/day: 86400

# q와 Q는 다음에 오는 문자열이 구분자에 해당한다. 구분 문자로 여는 괄호 [, {, (나 <를 사용하면 이에 대응하는 닫는 괄호나 문자가 나올 때까지 문자열로 취급한다. 그 외에는 같은 구분 문자가 나타날 때까지 문자열로 처리된다. 구분 문자로는 알파벳, 숫자, 2바이트 문자가 아닌 어떤 값이라도 사용할 수 있다.
# 마지막으로 히어 도큐먼트를 사용하여 문자열을 만들 수 있다.

string = <<END_OF_STRING
  The body of the string is the input lines up to
  one starting with the same text that followed the '<<'
END_OF_STRING

# 히어 도큐먼트는 << 다음에 오는 특정 문자열이 종결 문자열을 정의한다. 그러면 문자열은 종결 문자열까지가 되고, 여기서 종결 문자열은 제외된다. 보통 종결 문자열은 첫 번째 칼럼에서 시작한다. 하지만 종결 문자열에 마이너스(-) 부호를 사용하면 이 문자열도 들여쓰기를 할 수 있다.

string = <<-END_OF_STRING
  The body of the string is the input lines up to
  one starting with the same text that followed the '<<'
  END_OF_STRING

# 또한 하나의 행에서 여러 히어 도큐먼트를 가질 수도 있다. 이때 각 히어 도큐먼트는 각각의 문자열이 된다. 히어 도큐먼트들의 본문은 이어지는 줄들로부터 차례대로 가져온다.

print <<-STRING1, <<-STRING2
Concat
STRING1
  enate
  STRING2

# 이때 루비는 문자열 앞쪽의 공백 문자를 제거하지 않는다는 점에 주의가 필요하다.

# 모든 문자열은 연관된(associated) 인코딩을 가지고 있다. 문자열의 기본 인코딩은 이 문자열이 포함된 소스 파일의 인코딩에 의해 결정된다. 명시적인 인코딩 설정이 없다면 소스 파일과 그 파일에 포함된 문자열들은 루비 1.9에서는 US-ASCII가 되고 루비 2부터는 UTF-8이 된다.

plain_string = "dog"
puts RUBY_VERSION
puts "Encoding of #{plain_string.inspect} is #{plain_string.encoding}"

# 파일의 인코딩을 변경하면 파일 내의 모든 문자열의 인코딩 또한 변경된다.

# encoding: utf-8
plain_string = "dog"
puts "Encoding of #{plain_string.inspect} is #{plain_string.encoding}"
utf_string = "하이"
puts "Encoding of #{utf_string.inspect} is #{utf_string.encoding}"

# 엄밀하게 말하면 루비에는 문자를 나타내는 클래스가 없다. 문자는 단지 길이가 1인 문자열일 뿐이다. 하지만 역사적인 이유로 문자 상수는 문자(또는 문자를 나타내는 시퀀스) 앞에 물음표를 붙여서 만들 수 있다.

?a # => "a" (출력 가능한 문자)
?\n # => "\n" (개행 문자 (0x0a))
?\C-a # => "\u0001" (컨트롤 a)
?\M-a # => "\xE1" (메타는 비트 7을 설정한다)
?\M-\C-a # => "\x81" (메타 컨트롤 a)
?\C-? # => "\u007F" (삭제 문자)

# ?a 대신 "a"를 사용하고 ?\n 대신 "\n"을 사용하자.

# String 클래스는 아마 루비 내장 클래스 중에서 가장 클 것이다. 이 클래스에만 100개 이상의 표준 메서드가 정의되어 있다.

# 뮤직 플레이리스트 정보가 담긴 파일이 있다고 하자. 역사적인 문제로 노래 목록은 텍스트 파일에 행별로 저장되어 있다. 각 줄에는 노래 파일 이름, 재생 시간, 가수 제목이 세로 막대(|)로 구분되어 입력되어 있다.

# tut_stdtypes/songdata

# 데이터를 보니 String 클래스의 풍부한 메서드 중 일부를 사용해 각 필드를 추출, 정리해서 사용할 수 있을 것 같다. 이를 위해서는 최소한 다음과 같은 기능이 필요하다.
# - 한 줄을 필드별로 자르기
# - mm:ss 형태의 재생 시간을 초 단위로 변환
# - 가수 이름에 들어 있는 불필요한 공백 제거하기

# 우리의 첫 번째 목표인 필드별로 자르기는 String#split을 이용하면 아주 깔끔하게 처리할 수 있다. 앞의 파일의 경우에는 split 메서드에 정규 표현식 /\s*\|\s*/을 사용하면 공백을 선택적으로 포함한 세로 막대(|)로 나뉜 토큰 배열을 만들 수 있다. 그리고 파일에서 읽은 줄은 끝부분에 줄 바꿈을 포함하기 때문에, split 전에 String#chomp를 이용해서 줄 바꿈을 제거해야 한다. 다음으로 곡에 대한 좀 더 자세한 정보를 각각 세 개의 필드를 가지는 Struct에 저장할 것이다(Struct는 특정한 속성 세트로 이 경우에는 제목, 가수, 재생 시간이 저장된 데이터 구조체를 의미한다).

Song = Struct.new(:title, :name, :length)

File.open("tut_stdtypes/songdata") do |song_file|
  songs = []
  song_file.each do |line|
    file, length, name, title = line.chomp.split(/\s*\|\s*/)
    songs << Song.new(title, name, length)
  end

  puts songs[1]
end

# 불행히도 원래의 파일을 작성한 사람이 가수 이름을 여러 칼럼에 걸쳐서 입력한데다, 심지어 불필요한 공백들까지 포함하고 있기 때문에 이에 대한 전처리가 필요하다. 이를 처리하는 방법은 여러 가지가 있을 수 있지만, 가장 간단한 방법은 문자열에서 반복되는 문자열을 제거해 주는 String#squeeze 메서드를 이용하는 것이다. 문자열 자체를 바꾸기 위해 여기서는 squeeze! 메서드를 사용할 것이다.

Song = Struct.new(:title, :name, :length)

File.open("tut_stdtypes/songdata") do |song_file|
  songs = []

  song_file.each do |line|
    file, length, name, title = line.chomp.split(/\s*\|\s*/)
    name.squeeze(" ")
    songs << Song.new(title, name, length)
  end

  puts songs[1]
end

# 마지막으로 시간 표현 방식에 사소한 문제가 있다. 파일에는 2:58이라고 들어있지만, 우리는 178초로 입력받기를 원한다. 여기서 split 메서드를 다시 이용할 수 있다. split을 이용해서 콜론 문자(:)로 나누면 분과 초를 얻을 수 있다.

"2:58".split(/:/) # => ["2", "58"]

# 여기서는 split 메서드 대신에 비슷한 다른 메서드를 사용한다. String#scan은 패턴을 기반으로 자르기를 수행하는 split과 매우 비슷한 메서드다. 하지만 split과 다르게 scan 메서드에는 매치하기를 원하는 부분의 패턴을 넘겨준다. 우리 예제에서는 분과 초 부분 모두 하나 이상의 숫자를 매치하면 될 것이다. 하나 이상의 숫자를 나타내는 패턴은 /\d+/이다.

Song = Struct.new(:title, :name, :length)

File.open("tut_stdtypes/songdata") do |song_file|
  songs = []

  song_file.each do |line|
    file, length, name, title = line.chomp.split(/\s*\|\s*/)
    name.squeeze(" ")
    mins, secs = length.scan(/\d+/)
    songs << Song.new(title, name, mins.to_i*60 + secs.to_i)
  end

  puts songs[1]
end
