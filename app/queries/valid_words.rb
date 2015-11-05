class ValidWords
  def initialize(board)
    @board = board
  end

  def call
    DictionaryEntry.where('sorted_letters ~ :regex', regex: grid_regex).select &method(:is_word_valid?)
  end

  private

  def grid_regex
    @board.dictionary_entry.word.chars.sort.each_with_object([]) do |char, array|
      if array.size == @board.centre_letter_offset
        array << char
      else
        array << "#{char}?"
      end
    end
    .join
  end

  def is_word_valid?(dictionary_entry)
    WordValidator.new(@board, dictionary_entry).call
  end
end
