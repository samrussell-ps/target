class ValidWords
  def initialize(board)
    @board = board
  end

  def call
    DictionaryWord.where('sorted_letters ~ :regex', regex: "^#{grid_regex}$")
  end

  private

  def grid_regex
    @board.dictionary_word.word.chars.map.with_index do |char, offset|
      if offset == @board.centre_letter_offset
       char
     else
       "#{char}?"
     end
    end.sort.join
  end
end
