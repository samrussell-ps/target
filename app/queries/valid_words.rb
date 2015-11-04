class ValidWords
  def initialize(board)
    @board = board
  end

  def call
    DictionaryEntry.find_in_batches(batch_size: 1000).each_with_object([]) do |batch, output|
      output.concat batch.select { |dictionary_entry| is_word_valid?(dictionary_entry) }
    end
  end

  private

  def is_word_valid?(dictionary_entry)
    WordValidator.new(@board, dictionary_entry).call
  end
end
