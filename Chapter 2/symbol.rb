# 프로그래밍을 하다 보면 어떤 중요한 것에 대한 이름을 지어야만 할 때가 있다.
# 예를 들어 나침반의 4방향을 나타내는 이름에 대해 다음과 같이 상수를 정의할 수 있다.

NORTH = 1
EAST = 2
SOUTH = 3
WEST = 4

# 대부분의 경우 이렇게 상수에 특정 값을 대입하는 방법은 특별히 문제가 되지 않지만, 루비에는 이에 대한 좀 더 깔끔한 대안이 있다.
# 심벌은 미리 정의할 필요가 없는 동시에 유일한 값이 보장되는 상수 이름이다.
# 심벌 리터럴은 콜론(:)으로 시작하며 그 다음에 이름이 온다.

walk(:north)
look(:east)

# 심벌에는 값을 직접 부여하지 않아도 된다. 루비가 직접 고유한 값을 부여한다.
# 또한 프로그램의 어디에서 사용하더라도 특정한 이름의 심벌은 항상 같은 값을 가진다. 따라서 다음과 같은 코드를 작성할 수도 있다.

def walk(direction)
  if direction == :north
    # ...
  end
end

# 심벌은 해시의 키로 자주 사용된다.

inst_section = {
  :cello => 'string',
  :clarinet => 'woodwind',
  :drum => 'percussion',
  :oboe => 'woodwind',
  :trumpet => 'brass',
  :violin => 'string'
}
inst_section[:oboe] # => "woodwind"
inst_section[:cello] # => "string"
inst_section['cello'] # => nil

# 루비에서는 해시의 키로 심벌을 사용하는 경우가 많으므로 이를 위한 축약 표현이 준비되어 있다.
# 키가 심벌인 경우에는 name: value와 같이 줄여 쓸 수 있다.

inst_section = {
  cello: 'string',
  clarinet: 'woodwind',
  drum: 'percussion',
  oboe: 'woodwind',
  trumpet: 'brass',
  violin: 'string'
}
puts "An oboe is a #{inst_section[:oboe]} instrument"
