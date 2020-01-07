require 'csv'
require_relative 'book_in_stock'

class CsvReader
  def initialize
    @books_in_stock = []
  end

  def read_in_csv_data(csv_file_name)
    CSV.foreach(csv_file_name, headers: true) do |row|
      @books_in_stock << BookInStock.new(row["ISBN"], row["Price"])
    end
  end

  def total_value_in_stock
    sum = 0.0
    @books_in_stock.each {|book| sum += book.price}
    sum
  end

  def number_of_each_isbn
    # ...
  end
end

# CsvReader 클래스는 두 개의 외부 라이브러리에 의존한다. 첫 번째는 CSV 라이브러리이고 두 번째는 BookInStock 클래스를 포함하는 book_in_stock.rb 파일이다. 루비는 외부 파일을 읽어 들이기 위한 헬퍼 메서드를 제공한다. 이 파일에선 require를 사용해서 루비의 CSV 라이브러리를 읽어 들이고, require_relative를 사용해서 book_in_stock.rb 파일을 읽어 들인다(여기서 require_relative을 사용하는 것은 로드하려는 파일의 위치가 로드하는 파일을 기준으로 상대 위치에 있기 때문이다. 여기서 두 파일은 모두 같은 위치에 있다).
