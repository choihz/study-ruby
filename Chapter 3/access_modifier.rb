# 클래스 인터페이스를 설계할 때, 클래스를 외부에 어느 정도까지 노출할지 결정하는 것은 중요한 일이다. 클래스에 너무 깊이 접근하도록 허용하면, 우리의 애플리케이션에서 각 요소 간의 결합도(coupling)가 높아질 우려가 있다. 다시 말하면 이 클래스의 사용자 코드는 클래스 내부 구현의 세세한 부분에까지 종속적이 되기 쉽다는 것이다. 한 가지 기쁜 소식은 루비에서 객체 상태를 변경하는 방법이 메서드를 호출하는 것뿐이란 점이다. 메서드에 대한 접근을 적절히 설정하면 객체에 대한 접근을 제어할 수 있는 셈이다. 경험적으로 볼 때 객체의 상태를 망가뜨릴 수 있는 메서드는 노출해서는 안 된다.
# 루비에는 다음 세 가지 보호 단계가 있다.
# public 메서드는 누구나 호출할 수 있다. 아무런 접근 제어를 하지 않는다. 루비에서 메서드는 기본적으로 public이다(단, initialize는 예외적으로 항상 private이다).
# protected 메서드는 그 객체를 정의한 클래스와 하위 클래스에서만 호출할 수 있다. 접근이 가계도상으로 제한되는 것이다.
# private 메서드는 수신자를 지정해서 호출할 수 없다. 이 메서드의 수신자는 항상 self이기 때문이다. 다시 말하면 private 메서드는 오직 현재 객체의 문맥 하에서만 호출할 수 있다는 것이다. 즉, 다른 객체의 private 메서드에는 접근할 수 없다.

# protected와 private의 차이는 매우 미묘하고, 또한 일반적인 객체 지향 언어와는 좀 다르기도 하다. 어떤 메서드가 protected이면 정의한 클래스나 그 하위 클래스의 어떠한 인스턴스에서도 호출할 수 있다. 하지만 메서드가 private이면 오직 그 객체 자신에서만 호출할 수 있다. 어떠한 경우에도 다른 객체의 private 메서드를 직접 호출할 수는 없다. 그 객체가 호출하는 객체와 같은 클래스인 경우에도 말이다.
# 루비와 다른 객체 지향 언어의 중요한 차이점이 또 하나 있다. 접근 제어가 동적으로 결정된다는 것, 즉 정적이 아니라 프로그램이 실행될 때 결정된다는 것이다. 따라서 접근 위반 예외는 제한된 메서드를 실제로 호출한 그 순간에만 발생하게 된다.

# 클래스나 모듈을 정의할 때 public, protected, private 함수를 사용해서 접근 제어를 기술할 수 있다. 방법은 크게 두 가지가 있다.
# 아무 인자 없이 함수를 사용한다면, 이 세 가지 함수 다음에 오는 메서드의 기본 접근 제한 단계를 정한다. 이는 C++나 자바 프로그래머에게는 친숙한 방식일 것이다. public 등의 키워드를 사용하는 것과 같은 효과를 발휘하기 때문이다.

class MyClass

  def method1 # 기본값은 'public'이다
    # ...
  end

protected # 이제부터 선언하는 메서드는 모두 'protected'가 된다
  def method2 # 'protected'가 된다
    # ...
  end

private # 이제부터 선언하는 메서드는 모두 'private'이 된다
  def method3 # 'private'이 된다
    # ...
  end

public # 이제부터 선언하는 메서드는 모두 'public'이 된다
  def method4 # 'public'이 된다
    # ...
  end

end

# 다른 방법으로는 접근 제어 함수 뒤에 인자로 메서드 이름을 써 주는 방법이 있다. 이미 정의된 메서드의 접근 단계도 다시 정의할 수 있다.

class MyClass
  def method1
  end
  def method2
  end
  # 중략

  public :method1, :method4
  protected :method2
  private :method3
end

# 이제 예제를 살펴볼 시간이다. 모든 대변이 대응하는 차변을 가지는 잘 연결된 회계 시스템을 모델링하고 있다고 해 보자. 우리는 누구도 이 규칙을 위반하는 것을 원치 않기 때문에, 예금 대변과 차변을 다루는 메서드를 private으로 만들고, 외부 인터페이스는 트랜잭션 방식으로 정의하고자 한다.

class Account
  attr_accessor :balance
  def initialize(balance)
    @balance = balance
  end
end

class Transaction

  def initialize(account_a, account_b)
    @account_a = account_a
    @account_b = account_b
  end

private

  def debit(account, amount)
    account.balance -= amount
  end
  def credit(account, amount)
    account.balance += amount
  end

public

  def transfer(amount)
    debit(@account_a, amount)
    credit(@account_b, amount)
  end

end

savings = Account.new(100)
checking = Account.new(200)

trans = Transaction.new(checking, saving)
trans.transfer(50)

# protected 접근은 객체가 같은 클래스에서 생성된 다른 객체의 상태에 접근할 필요가 있을 때 사용한다. 예를 들어 각각의 Account 객체의 결산 잔액을 비교하고 싶은데, 잔액 자체는 (아마 다른 형식으로 보여주고자 하기 때문에) 외부에 보여주고 싶지는 않은 경우를 보자.

class Account
  attr_reader :cleared_balance # 접근자 메서드 'cleared_balance'를 만든다
  protected :cleared_balance # 접근자 메서드를 protected 메서드로 설정한다

  def greater_balance_than?(other)
    @cleared_balance > other.cleared_balance
  end
end

# cleared_balance는 protected이므로 Account 객체에서만 접근 가능하다.
