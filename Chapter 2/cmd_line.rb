# 루비 프로그램을 명령행에서 실행할 때 인자를 넘겨줄 수 있다. 이렇게 넘겨받은 인자에 접근하는 방법은 두 가지가 있다.
# 첫 번째는 ARGV 배열을 사용하는 방법이다. ARGV 배열에는 프로그램에 넘겨진 각 인자가 저장된다.

puts "You gave #{ARGV.size} arguments"
p ARGV

# 인자를 지정해 이 프로그램을 실행하면 프로그램에 넘겨진 인자가 출력된다.

# $ ruby cmd_line.rb ant bee cat dog
# You gave 4 arguments
# ["ant", "bee", "cat", "dog"]

# 대부분의 경우 프로그램에 넘겨지는 인자는 처리하고자 하는 파일들의 이름이 된다. 그럴 때는 명령행 인자를 참조하는 두 번째 방법인 ARGF를 사용할 수 있다.
# ARGF는 명령행에서 넘겨진 이름을 가진 모든 파일의 내용을 가지고 있는 특수한 I/O 객체다(단, 파일 이름을 넘기지 않았다면 표준 입력을 사용한다).
