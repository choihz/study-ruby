# 블록은 익명 메서드와 비슷하지만 단순히 이걸로 끝은 아니다. 블록은 객체로 변환할 수 있으며, 이 객체를 변수에 저장할 수도 있고, 어딘가에 넘겨줄 수도 있으며, 나중에 호출할 수도 있다.
# 앞서 블록은 메서드에 넘겨지는 추가적인 매개 변수로 생각해도 무방하다고 이야기한 바 있다. 사실은 암묵적인 매개 변수일 뿐 아니라 명시적인 매개 변수로 사용할 수도 있다.
# 메서드를 정의할 때 마지막 매개 변수에 앰퍼샌드(&)를 접두사로 붙이면(예를 들어 &action과 같이) 루비는 이 메서드가 호출될 때마다 코드 블록이 넘겨졌는지 찾아본다. 이 코드 블록은 Proc 클래스의 객체로 변환되어 매개 변수로 넘겨진다. 이렇게 넘겨진 코드 블록은 여느 매개 변수와 마찬가지로 다룰 수 있다.
# 다음은 특정 인스턴스 메서드에서 Proc 객체를 생성하고 이를 인스턴스 변수에 저장하고, 다른 인스턴스 메서드에서 이를 호출하는 예제다.

class ProcExample
  def pass_in_block(&action)
    @stored_proc = action
  end
  def use_proc(parameter)
    @stored_proc.call(parameter)
  end
end

eg = ProcExample.new
eg.pass_in_block { |param| puts "The parameter is #{param}" }
eg.use_proc(99)

# proc 객체에 대해 call 메서드를 호출함으로써 원래의 블록을 호출한다는 점에 주의할 필요가 있다.
# 많은 루비 프로그래머들이 이러한 방식으로 블록을 변수에 저장하며 이후에 다시 호출한다. 이는 콜백이나 디스패치 테이블 등을 구현하는 훌륭한 방법이다. 여기서 좀 더 나아갈 수도 있다. 메서드에서 매개 변수 맨 앞에 앰퍼샌드를 붙여 블록을 객체로 변환할 수 있다면, 이 메서드에서 Proc 객체를 실행하고 그 결과를 다시 반환한다면 어떻게 될까?

# def create_block_object(&block)
#   block
# end
# bo = create_block_object { |param| puts "You called me with #{param}" }
# bo.call 99
# bo.call "cat"

# 이러한 아이디어는 무척 유용하기에 루비에서는 블록을 객체로 변환하는 내장 메서드를 두 가지나 지원한다. lambda와 Proc.new가 바로 그것이다. 두 메서드는 블록을 받아서 Proc 객체를 반환한다.

bo = lambda { |param| puts "You called me with #{param}" }
bo.call 99
bo.call "cat"
