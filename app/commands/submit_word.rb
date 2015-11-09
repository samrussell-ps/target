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

  def dictionary_word
    @dictionary_word ||= DictionaryWord.find_by_word(word_to_submit)
  end

  def submit_word
    @board.submitted_words.create!(dictionary_word: dictionary_word) if valid?
  end

  def valid?
    if dictionary_word.nil?
      error(:word_is_not_in_dictionary)
    elsif is_word_not_in_grid?
      error(:word_is_not_in_grid)
    elsif has_word_been_submitted?
      error(:word_has_been_submitted)
    end

    return @errors.empty?
  end

  def is_word_not_in_grid?
    ValidWords.new(@board).call.exclude?(dictionary_word)
  end

  def has_word_been_submitted?
    @board.submitted_words.includes(:dictionary_word).any? { |submitted_word| submitted_word.dictionary_word.word == word_to_submit }
  end

  def error(symbol)
    @errors << ERROR_MESSAGES[symbol]
  end
end

