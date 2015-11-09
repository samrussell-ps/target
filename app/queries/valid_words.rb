class ValidWords
  def initialize(board)
    @board = board
  end

  def call
    DictionaryWord.where('sorted_letters ~ :regex', regex: "^#{grid_regex}$")
  end

  private

  def grid_regex
    @board.dictionary_word.word.chars.each_with_object([]) do |char, array|
      if array.size == @board.centre_letter_offset
        array << char
      else
        array << "#{char}?"
      end
    end
    .sort
    .join
  end
end
