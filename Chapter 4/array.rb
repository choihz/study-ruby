# 실제로 사용되는 대부분의 프로그램은 데이터 컬렉션을 처리한다. 예를 들어 강의를 듣는 사람들, 재생 목록에 등록된 노래 제목들, 서점에 있는 책 목록이 그 대상이 될 수 있다. 루비에는 이러한 컬렉션을 다루기 위한 배열과 해시라는 두 개의 내장 클래스가 준비되어 있다. 이 두 클래스에 익숙해지는 것이 실력 있는 루비 프로그래머가 되는 지름길이다. 두 클래스는 매우 다양한 기능을 제공하므로 이를 전부 익히는 데는 상당한 시간을 필요로 한다.
# 하지만 루비에서 컬렉션을 다루기 위한 클래스가 배열과 해시만 있는 것이 아니다. 루비에는 코드 덩어리를 캡슐화할 수 있도록 도와주는 블록이라는 문법이 있다. 블록과 컬렉션을 함께 사용하면 강력한 반복자 구문이 된다. 이번 장에서는 배열과 해시를 비롯해 블록과 반복자를 다룬다.

# Array 클래스는 객체 참조를 컬렉션으로 저장한다. 각 객체의 참조는 배열에서 하나의 위치를 차지하며 이 위치는 음이 아닌 정수로 표현된다.
# 배열을 만들 때는 리터럴을 사용하거나 명시적으로 Array 객체를 생성할 수 있다. 배열 리터럴을 이용할 때는 간단히 대괄호 사이에 포함하고자 하는 객체를 나열하면 된다.

a = [ 3.14159, "pie", 99 ]
a.class # => Array
a.length # => 3
a[0] # => 3.14159
a[1] # => "pie"
a[2] # => 99
a[3] # => nil

b = Array.new
b.class # => Array
b.length # => 0
b[0] = "second"
b[1] = "array"
b # => ["second", "array"]

# 배열의 [] 연산자를 이용하면 위치를 지정할 수 있다. 루비의 다른 연산자처럼 이것도 사실은 메서드이므로(정확히는 Array 클래스의 인스턴스 메서드) 하위 클래스에서 재정의할 수 있다. 앞선 예제에서 알 수 있듯이 배열의 인덱스는 0부터 시작한다. 배열의 위치를 음이 아닌 정수로 지정하면 해당 위치의 객체를 반환하고 그 위치에 아무것도 없다면 nil을 반환한다. 음수로 위치를 지정하면 배열의 뒤에서부터 위치를 계산해 해당하는 위치의 값을 반환한다.

a = [ 1, 3, 5, 7, 9 ]
a[-1] # => 9
a[-2] # => 7
a[-99] # => nil

# 배열 인덱스를 [start, count]처럼 숫자 쌍으로 지정할 수도 있다. 이것은 시작점(start)에서 count만큼의 객체 참조를 뽑아서 새로운 배열을 만들어 반환한다.

a = [ 1, 3, 5 ,7, 9 ]
a[1, 3] # => [3, 5, 7]
a[3, 1] # => [7]
a[-3, 2] # => [5, 7]

# 마지막으로 인덱스에서 범위를 사용할 수도 있는데, 시작 위치와 끝 위치를 점 두 개 또는 세 개로 구분해서 적어주면 된다. 점 두 개를 사용하는 형식은 마지막 경곗값을 포함하고, 세 개를 사용하는 형식에서는 포함하지 않는다.

a = [ 1, 3, 5, 7, 9 ]
a[1..3] # => [3, 5, 7]
a[1...3] # => [3, 5]
a[3..3] # => [7]
a[-3..-1] # => [5, 7, 9]

# [] 연산자에 대응하는 []= 연산자도 있다. 이 연산자를 이용해 배열의 특정 위치에 값을 대입할 수 있다. 하나의 정수 인덱스를 사용할 때는 그 위치의 요소가 대입문의 오른쪽 편에 있는 값으로 바뀐다. 그리고 인덱스 사이에 간격이 생기면 이 사이의 값은 nil로 채워진다.

a = [ 1, 3, 5, 7, 9 ]
a[1] = 'bat' # => [1, "bat", 5, 7, 9]
a[-3] = 'cat' # => [1, "bat", "cat", 7, 9]
a[3] = [ 9, 8 ] # => [1, "bat", "cat", [9, 8], 9]
a[6] = 99 # => [1, "bat", "cat", [9, 8], 9, nil, 99]

# []= 연산자에 쓰인 인덱스가 두 개(시작 위치와 길이)거나 범위라면, 원래 배열의 해당하는 위치에 있는 원소들이 대입문의 오른쪽 편에 있는 값(어떤 형식이든 무방하다)으로 바뀐다. 길이가 0이라면 오른편의 값이 시작 위치 바로 앞에 삽입될 것이다. 대입문 오른편에도 배열이 오면 이 배열의 원소를 이용해 값을 바꿀 것이다. 왼편에서 선택된 요소의 수와 오른편에서 지정된 원소의 수가 다른 경우에도 배열 크기는 자동으로 조절된다.

a = [ 1, 3, 5, 7, 9 ]
a[2, 2] = 'cat' # => [1, 3, "cat", 9]
a[2, 0] = 'dog' # => [1, 3, "dog", "cat", 9]
a[1, 1] = [ 9, 8, 7 ] # => [1, 9, 8, 7, "dog", "cat", 9]
a[0..3] = [] # => ["dog", "cat", 9]
a[5..6] = 99, 98 # => ["dog", "cat", 9, nil, nil, 99, 98]

# 이 외에도 배열에는 유용한 메서드가 많다. 이를 활용하여 스택, 집합, 큐, 양방향 큐, FIFO 큐로 배열을 다룰 수 있다.
# 예를 들어 push와 pop을 사용하면 배열의 맨 뒤에 요소를 추가하거나, 맨 뒤의 요소를 제거할 수 있다. 이를 통해 배열을 스택으로 사용할 수 있다.

stack = []
stack.push "red"
stack.push "green"
stack.push "blue"
stack # => ["red", "green", "blue"]

stack.pop # => "blue"
stack.pop # => "green"
stack.pop # => "red"
stack # => []

# 비슷하게 unshift와 shift를 사용하면 배열 맨 앞의 요소를 추가하거나 삭제할 수 있다. shift와 push를 조합하면 배열을 선입선출(FIFO) 큐로 사용할 수 있다.

queue = []
queue.push "red"
queue.push "green"
queue.shift # => "red"
queue.shift # => "green"

# first와 last 메서드는 배열의 맨 앞이나 맨 뒤에서 n개의 요소들을 반환한다. 이때 앞선 메서드들과 달리 배열의 요소를 삭제하지는 않는다.

array = [ 1, 2, 3, 4, 5, 6, 7 ]
array.first(4) # => [1, 2, 3, 4]
array.last(4) # => [4, 5, 6, 7]
