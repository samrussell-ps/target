class ValidWords
  def initialize(board)
    @board = board
  end

  def call
    # TODO optimise - select loads this all into memory
    DictionaryEntry.select { |dictionary_entry| is_word_valid?(dictionary_entry) }
  end

  private

  def is_word_valid?(dictionary_entry)
    WordValidator.new(@board, dictionary_entry).call
  end
end
