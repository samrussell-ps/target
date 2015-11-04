class SubmitWord
  ERROR_MESSAGES = {
    word_is_not_in_dictionary: "Word is not in dictionary",
    word_is_not_in_grid: "Word is not in grid",
    word_does_not_use_centre_letter: "Word must use the centre letter",
    word_has_been_submitted: "Word has been submitted"
  }

  attr_reader :errors

  def initialize(board, word)
    @board = board
    @word = word
    @errors = []
  end

  def call
    submit_word

    @errors.empty?
  end

  private

  def word_to_submit
    @word_to_submit ||= @word.to_s.upcase
  end

  def dictionary_entry
    @dictionary_entry ||= DictionaryEntry.find_by_word(word_to_submit)
  end

  def word_validator
    @word_validator ||= WordValidator.new(@board, dictionary_entry)
  end

  def submit_word
    @board.submitted_words.create!(dictionary_entry: dictionary_entry) unless find_errors
  end

  def find_errors
    if dictionary_entry.nil?
      error(:word_is_not_in_dictionary)
    elsif is_word_invalid?
      word_validator.errors.each { |symbol| error(symbol) }
    elsif has_word_been_submitted?
      error(:word_has_been_submitted)
    end

    return @errors.present?
  end

  def is_word_invalid?
    word_validator.call == false
  end

  def has_word_been_submitted?
    @board.submitted_words.any? { |submitted_word| submitted_word.dictionary_entry.word == word_to_submit }
  end

  def error(symbol)
    @errors << ERROR_MESSAGES[symbol]
  end
end

