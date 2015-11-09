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

  def word_validator
    @word_validator ||= WordValidator.new(@board, dictionary_word)
  end

  def submit_word
    find_errors

    @board.submitted_words.create!(dictionary_word: dictionary_word) if @errors.empty? # TODO valid instead of find_errors (it's okay that this mutates state)
  end

  def find_errors
    if dictionary_word.nil?
      error(:word_is_not_in_dictionary)
    elsif is_word_invalid?
      word_validator.errors.each &method(:error)
    elsif has_word_been_submitted?
      error(:word_has_been_submitted)
    end

    return @errors.present?
  end

  def is_word_invalid?
    word_validator.call == false
  end

  def has_word_been_submitted?
    # TODO @board.submitted_words.includes(:dictionary_word).any? ... = one db query instead of N
    @board.submitted_words.any? { |submitted_word| submitted_word.dictionary_word.word == word_to_submit }
  end

  def error(symbol)
    @errors << ERROR_MESSAGES[symbol]
  end
end

