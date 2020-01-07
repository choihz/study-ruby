# 객체 지향 설계에서는 외부의 대상을 파악하고 이를 코드를 통해 클래스로 만든다. 하지만 설계상에서 클래스의 대상이 되는 또 다른 대상이 있다. 이는 외부가 아닌 내부 코드 자체에 대응하는 클래스다.
# 예를 들어 우리가 만들고자 하는 프로그램에서는 CSV 데이터를 읽어 들여 통계를 내고 요약해야 한다. 하지만 이는 매우 소극적인 표현이다. 어떻게 통계를 내고 요약할지에 따라서 이를 어떻게 설계할지가 결정되기 때문이다. 그리고 그 답은(이 문제에 한해서) CSV 리더에 있다. 먼저 다음과 같은 클래스를 정의하자.

class CsvReader
  def initialize
    # ...
  end

  def read_in_csv_data(csv_file_name)
    # ...
  end

  def total_value_in_stock
    # ...
  end

  def number_of_each_isbn
    # ...
  end
end

# 이 클래스는 다음과 같이 호출할 수 있다.

reader = CsvReader.new
reader.read_in_csv_data("file1.csv")
reader.read_in_csv_data("file2.csv")
# ...
puts "Total value in stock = #{reader.total_value_in_stock}"

# 다수의 CSV 파일을 읽어 들이기 위해 reader 객체에 넘겨 읽어 들인 값들을 축적할 필요가 있다. 이를 위해 인스턴스 변수의 값을 배열로 저장하자. 각 책들의 데이터를 나타내기 위해서는 어떻게 해야 할까?
# 이는 앞서 정의한 BookInStock 클래스에서 이미 해결했다. 이제 CSV 파일을 어떻게 분석할지 하는 문제가 남았다. 다행히도 루비에는 훌륭한 CSV 라이브러리가 있다. 주어진 CSV 파일에 헤더 라인이 있다고 가정하고 나머지 라인을 반복적으로 읽어 들여 이름으로 값을 뽑아낸다.

class CsvReader
  def initialize
    @books_in_stock = []
  end

  def read_in_csv_data(csv_file_name)
    CSV.foreach(csv_file_name, headers: true) do |row|
      @books_in_stock << BookInStock.new(row["ISBN"], row["Price"])
    end
  end
end

# read_in_csv_data 메서드의 첫 번째 라인에서는 CSV 라이브러리를 통해 주어진 파일을 연다. headers: true 옵션은 파일의 첫 번째 행을 각 열의 이름으로 분석할지 여부를 나타낸다.
# CSV 라이브러리는 파일의 나머지 내용을 읽어오며 각각의 줄을 블록(do와 end 사이의 코드)에 넘겨준다. 블록에서는 ISBN과 Price 칼럼의 데이터를 읽어들여 BookInStock 객체를 생성한다. 이렇게 생성한 객체를 @books_in_stock 인스턴스 변수에 더한다. 이 변수는 어디에서 온 걸까? 이 배열은 initialize 메서드에서 생성한 배열이다.
# 여기서도 지향해야 할 패턴을 하나 알 수 있다. initialize 메서드는 객체의 환경을 초기화해서 이를 사용 가능한 상태로 만들어 두어야 한다. 다른 메서드들에서는 이 상태를 사용한다.
# 그렇다면 이제 이 코드 조각들을 통해 작동하는 프로그램을 만들어 보자. 여기서는 코드를 세 개의 파일로 만든다. 첫 번째 파일은 book_in_stock.rb다. 이 파일은 BookInStock 클래스의 정의를 포함한다. 두 번째는 csv_reader.rb다. 이 파일에는 CsvReader 클래스가 정의되어 있다. 그리고 메인 프로그램을 포함하는 stock_stats.rb다.
