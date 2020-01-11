# 지금까지 구현한 내용에 대해 간단한 테스트를 해 보자. 이를 위해 표준 루비 배포판에 포함된 테스트 프레임워크인 Test::Unit을 사용한다.

# 여기서는 assert_equal 메서드를 사용해서 두 개의 매개 변수가 같은지 비교한다. 일단 이 메서드에 대해서는 두 매개 변수가 같은지를 확인하고, 같지 않으면 예외를 발생시킨다는 정도만 알아두자. 두 메서드를 테스트하기 위해 한 메서드당 하나씩 단언(assertions)을 사용한다(메서드를 두 개로 분리한 것은 독립적으로 테스트 가능하게 만들기 위해서다).
# word_from_string 메서드를 테스트하는 클래스는 다음과 같다.

require_relative 'words_from_string'
require 'test/unit'

class TestWordsFromString < Test::Unit::TestCase

  def test_empty_string
    assert_equal([], words_from_string(""))
    assert_equal([], words_from_string("       "))
  end

  def test_single_word
    assert_equal(["cat"], words_from_string("cat"))
    assert_equal(["cat"], words_from_string("   cat   "))
  end

  def test_many_words
    assert_equal(["the", "cat", "sat", "on", "the", "mat"],
        words_from_string("the cat sat on the mat"))
  end

  def test_ignores_punctuation
    assert_equal(["the", "cat's", "mat"],
        words_from_string("<the!> cat's, -mat-"))
  end
end

# test는 먼저 words_from_string 메서드를 읽어 들이는 것부터 시작하며, 그런 다음에 단위 테스트 프레임워크를 읽어 들인다. 이어서 테스트 클래스를 정의한다. 이 클래스에 정의된 메스드들 중 test로 시작하는 모든 메서드는 테스트 프레임워크에 의해 자동으로 실행된다. 실행 결과로 네 개의 메서드가 실행되었으며 여섯 개의 단언이 성공적으로 실행되었음을 알 수 있다.
