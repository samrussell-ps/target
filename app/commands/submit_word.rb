class SubmitWord
  ERROR_MESSAGES = {
    word_is_invalid: "Word is invalid"
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

  def board
    @board
  end

  def submit_word
    begin
      dictionary_entry = DictionaryEntry.find_by_word!(word_to_submit)

      board.submitted_words.create!(dictionary_entry: dictionary_entry)
    rescue ActiveRecord::RecordNotFound
      set_error(:word_is_invalid)
    end
  end

  def set_error(symbol)
    @errors << ERROR_MESSAGES[symbol]
  end
end

