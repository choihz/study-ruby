# 루비 해시도 배열과 비슷하다.
# 해시 리터럴은 대괄호 대신 중괄호를 사용한다.
# 해시에서는 중괄호 안의 구성 요소 하나당 두 개의 객체를 포함해야 하는데, 하나는 키이고 다른 하나는 값이다.
# 키와 값은 일반적으로 =>를 통해 구분된다.

inst_section = {
  'cello' => 'string',
  'clarinet' => 'woodwind',
  'drum' => 'percussion',
  'oboe' => 'woodwind',
  'trumpet' => 'brass',
  'violin' => 'string'
}

# => 왼쪽에 있는 것이 키이고, 오른쪽에 있는 것이 키가 가리키는 값이다.
# 특정 해시 안에서 키는 유일해야 한다.
# 해시에서 키와 값에는 어떤 객체가 와도 상관없다. 심지어 값이 배열이거나 키가 해시인 해시를 만드는 것도 가능하다.

# 해시에 담긴 객체를 얻기 위해서는 배열과 마찬가지로 대괄호를 사용한다.
# 다음 예제에서 보듯이 p 메서드는 객체의 값을 화면에 출력한다.
# 이는 puts와 비슷하게 작동하지만 nil과 같은 객체도 명시적으로 출력한다.

p inst_section['oboe']
p inst_section['cello']
p inst_section['bassoon']

# 해시는 주어진 키에 해당하는 객체가 없을 때는 기본적으로 nil을 반환한다.
# 해시의 기본값을 따로 설정하기 위해서는 해시 객체를 생성할 때 기본값을 넘겨주면 된다.

histogram = Hash.new(0) # 기본값은 0이다.
histogram['ruby'] # => 0
histogram['ruby'] = histogram['ruby'] + 1
p histogram['ruby'] # => 1
