def count_frequency(word_list)
  counts = Hash.new(0)
  for word in word_list
    counts[word] += 1
  end
  counts
end

p count_frequency(["sparky", "the", "cat", "sat", "on", "the", "mat"])

# 아직 사소한 문제가 하나 남아 있다. 단어의 출현 빈도가 저장된 해시에는 먼저 나타난 단어부터 차례대로 저장된다. 하지만 최종적인 결과는 많이 출현한 단어부터 보여주는 게 더 나아 보인다.
# sort_by 메서드를 사용해 이를 구현할 수 있다. sort_by를 사용하면 블록을 통해 정렬을 할 때 어떤 값을 사용할지 지정할 수 있다. 여기서는 출현 횟수로 정렬해야 한다. 정렬한 결과는 요소가 두 개인 서브 배열에 대한 배열이 된다. 각 서브 배열에는 원래 해시의 키와 값의 쌍이 저장된다. 여기까지 구현된 프로그램은 다음과 같다.

# word_freq/temp.rb
