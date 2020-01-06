# 일반적으로 객체 외부에서 객체 상태에 접근하거나 조작하는 메서드를 별도로 정의해서 외부에서도 객체 상태에 접근 가능하도록 만들어 준다. 이렇듯 객체의 내부가 외부에 노출되는 부분을 객체의 속성(attribute)이라고 부른다.
# BookInStock 객체에 대해 외부에서 찾을 수 있어야 하는 내용이 바로 ISBN과 가격이다. 이를 구현하는 방법 중 하나는 접근자 메서드를 직접 구현하는 것이다.

class BookInStock
  def initialize(isbn, price)
    @isbn = isbn
    @price = price
  end
  def isbn
    @isbn
  end
  def price
    @price
  end
end

book = BookInStock.new("isbn1", 12.34)
puts "ISBN = #{book.isbn}"
puts "Price = #{book.price}"

# 이 예제에서는 두 인스턴스 변수에 접근할 수 있도록 해주는 두 개의 접근자 메서드를 직접 구현했다. 예를 들어 isbn 메서드는 인스턴스 변수 @isbn에 저장된 정보를 반환한다(루비에서는 기본적으로 메서드 마지막에 평가된 표현식의 평가 결과를 반환하는데, 여기서 마지막 표현식은 단순히 인스턴스 변수의 값 자체이다).
# 접근자 메서드는 매우 자주 사용되므로, 루비는 이를 쉽게 정의해 주는 편의 메서드를 제공한다. attr_reader 메서드는 앞에서 작성한 것과 같은 접근자 메서드를 대신 생성해 줄 것이다.

class BookInStock

  attr_reader :isbn, :price

  def initialize(isbn, price)
    @isbn = isbn
    @price = price
  end
  
end

book = BookInStock.new("isbn1", 12.34)
puts "ISBN = #{book.isbn}"
puts "Price = #{book.price}"

# 앞선 예제에서 이번 장에서 처음으로 사용된 심벌 표현을 볼 수 있다. 심벌은 단순히 이름을 참조할 때 사용할 수 있는 편리한 방법이다. :isbn은 isbn이라는 이름을 지칭하며, 콜론 없이 isbn을 사용하면 이는 이 변수의 값 자체를 의미한다. 이 예제에서 접근자 메서드 이름으로 isbn과 price를 사용하고 있다. 여기에 대응하는 인스턴스 변수는 각각 @isbn과 @price다. 이렇게 생성된 접근자 메서드는 바로 앞 예제에서 직접 작성한 인스턴스 변수를 반환하는 메서드와 완전히 같다.

# 자바나 C#을 사용해 왔다면 attr_reader라는 표현이 언어 차원에서 인스턴스 변수를 쉽게 선언할 수 있도록 만들어진 선언문이라고 오해할지도 모른다. 하지만 진실은 그렇지 않다. 이는 접근자 메서드를 생성하지만 변수 자체는 선언할 필요가 없다. 변수는 이를 사용하고자 할 때 알아서 나타난다. 루비에서 인스턴스 변수와 접근자 메서드는 완전히 분리된 것이다.

# 객체 밖에서 속성을 설정해야 할 때도 있다. 예를 들어 책에 대한 정보를 스캔한 다음, 이 책을 할인하고자 한다면 이러한 정보를 설정하는 방법이 필요하다.
# C#이나 자바 같은 언어에서는 세터(setter) 함수를 사용할 것이다.

# class JavaBookInStock {
#   private double _price;
#   public double getPrice() {
#     return _price;
#   }
#   public void setPrice(double newPrice) {
#     _price = newPrice;
#   }
# }
# b = new JavaBookInStock(...);
# b.setPrice(calculate_discount(b.getPrice()));

# 루비에서는 객체의 속성에도 다른 변수와 마찬가지로 접근 가능하다. 이는 앞선 예제의 book.isbn과 같은 표현에서 확인할 수 있다. 접근 가능한 속성에 값을 대입하는 것도 매우 자연스러운 일이다. 루비에서는 메서드 이름 뒤에 = 기호를 사용해 대입 기능을 구현할 수 있다. 이렇게 만들어진 메서드는 값을 대입하는 데 사용할 수 있다.

class BookInStock

  attr_reader :isbn, :price

  def initialize(isbn, price)
    @isbn = isbn
    @price = price
  end

  def price=(new_price)
    @price = new_price
  end

end

book = BookInStock.new("isbn1", 33.80)
puts "ISBN = #{book.isbn}"
puts "Price = #{book.price}"
book.price = book.price * 0.75 # 할인 가격
puts "New price = #{book.price}"

# book.price = book.price * 0.75라는 대입문은 book 객체의 price= 메서드를 호출하고 인자로 할인된 가격을 넘겨준다. 이름이 =로 끝나는 메서드를 정의하면 = 앞의 메서드 이름을 대입문의 좌변에 사용할 수 있게 된다.
# 루비는 이러한 대입 메서드를 만드는 간단한 표현을 제공한다. 값을 대입하는 메서드만 만들고 싶다면 attr_writer를 사용하면 된다. 하지만 이런 경우는 매우 드물다. 일반적으로는 인스턴스 변수의 값을 속성으로 읽는 것과 대입하는 것을 모두 필요로 한다. 루비는 이를 위한 메서드들을 한 번에 정의해주는 attr_accessor 메서드를 제공한다.

class BookInStock
  attr_reader :isbn
  attr_accessor :price

  def initialize(isbn, price)
    @isbn = isbn
    @price = price
  end
end

book = BookInStock.new("isbn1", 33.80)
puts "ISBN = #{book.isbn}"
puts "Price = #{book.price}"
book.price = book.price * 0.75 # 할인 가격
puts "New pricec = #{book.price}"

# 속성에 접근하는 메서드가 단지 객체의 인스턴스 변수를 읽거나 대입하는 간단한 메서드일 필요는 없다. 예를 들어 달러 단위의 부동소수점 표현이 아니라 센트 단위까지 좀 더 정확한 가격을 표기하고 싶을 수 있다.

class BookInStock

  attr_reader :isbn
  attr_accessor :price

  def initialize(isbn, price)
    @isbn = isbn
    @price = price
  end

  def price_in_cents
    Integer(price * 100 + 0.5)
  end

end

book = BookInStock.new("isbn1", 33.80)
puts "Price = #{book.price}"
puts "Price in cents = #{book.price_in_cents}"

# 여기서 한 걸음 더 나아가 가상 속성에 대한 대입이 가능하도록 만들 수도 있다. 이는 가상 속성값을 인스턴스 변수에 매핑하는 방법으로 이루어진다.

class BookInStock

  attr_reader :isbn
  attr_accessor :price

  def initialize(isbn, price)
    @isbn = isbn
    @price = price
  end

  def price_in_cents
    Integer(price * 100 + 0.5)
  end

  def price_in_cents=(cents)
    @price = cents / 100.0
  end

end

book = BookInStock.new("isbn1", 33.80)
puts "Price = #{book.price}"
puts "Price in cents = #{book.price_in_cents}"

book.price_in_cents = 1234
puts "Price = #{book.price}"
puts "Price in cents = #{book.price_in_cents}"

# 여기서는 속성 메서드를 사용해서 가상 인스턴스 변수를 생성한다. 객체의 밖에서 price_in_cents는 다른 속성들과 마찬가지로 그저 객체의 속성으로 보인다. 하지만 내부적으로 이 속성에 대응하는 인스턴스 변수는 존재하지 않는다.
# 이를 통해 인스턴스 변수와 계산된 값의 차이점을 숨겨서, 클래스 구현에서 나머지 세상을 보호할 수 있는 방법을 제공할 수 있다. 다시 말해 우리가 만든 클래스를 사용할 수백만 줄의 코드에 영향을 주지 않고 내부 구현을 바꿀 수 있게 된 것이다.

# 지금까지의 설명을 읽고는 속성이 단지 메서드일 뿐이라는 생각을 하게 되었을지도 모른다. 그렇다면 굳이 속성이라고 따로 부를 필요가 있을까? 어떤 면에서 보자면 이는 정확한 지적이다. 속성은 단지 메서드일 뿐이다. 속성은 때때로 단순히 인스턴스 변수의 값을 반환한다. 속성은 때때로 계산 결과를 반환하기도 한다. 그리고 이름 끝에 등호를 달고 멋을 부린 메서드를 만들어 객체의 상태를 바꾸는 용도로 사용하기도 한다. 이제 우리의 질문은 어디까지가 속성이고 어디서부터가 일반 메서드인가 하는 것이다. 속성을 일반 메서드와 구분 짓는 차이점은 무엇일까? 사실 이는 지극히 쓸데없는 논쟁이다. 적당히 취향대로 골라잡으면 된다.
# 클래스를 설계할 때는 내부적으로 어떤 상태를 가지고, 이 상태를 외부(그 클래스의 사용자)에 어떤 모습으로 노출할지 결정해야 한다. 여기서 내부 상태는 인스턴스 변수에 저장한다. 외부에 보이는 상태는 속성(attribute)이라고 부르는 메서드를 통해야만 한다. 그 밖에 클래스가 할 수 있는 모든 행동은 일반 메서드를 통해야만 한다. 이런 구분법이 아주 중요한 것은 아니지만, 그래도 객체의 외부 상태를 속성이라고 부른다면 클래스를 사용하는 사람이 우리가 만든 클래스를 어떻게 봐야 하는지에 대한 힌트를 줄 수 있을 것이다.
