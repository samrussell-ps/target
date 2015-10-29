class SubmitWord
  ERROR_MESSAGES = {
    word_is_not_in_dictionary: "Word is not in dictionary",
    word_is_not_in_grid: "Word is not in grid"
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
    if is_word_in_grid?
      begin
        dictionary_entry = DictionaryEntry.find_by_word!(word_to_submit)

        board.submitted_words.create!(dictionary_entry: dictionary_entry)
      rescue ActiveRecord::RecordNotFound
        set_error(:word_is_not_in_dictionary)
      end
    else
      set_error(:word_is_not_in_grid)
    end
  end

  def is_word_in_grid?
    word_character_frequency.all? do |char, count|
      grid_character_frequency[char] >= count
    end
  end

  # TODO dedup
  def grid_character_frequency
    @board.dictionary_entry.word.chars.each_with_object(Hash.new(0)) do |char, counts|
      counts[char] += 1
    end
  end

  def word_character_frequency
    word_to_submit.chars.each_with_object(Hash.new(0)) do |char, counts|
      counts[char] += 1
    end
  end

  def set_error(symbol)
    @errors << ERROR_MESSAGES[symbol]
  end
end

