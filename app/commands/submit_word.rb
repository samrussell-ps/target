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

  def board
    @board
  end

  def submit_word
    begin
      dictionary_entry = DictionaryEntry.find_by_word!(word_to_submit)

      #TODO logic here is yuck
      if has_word_been_submitted?(dictionary_entry)
        set_error(:word_has_been_submitted)
      elsif !is_word_in_grid?
        set_error(:word_is_not_in_grid)
      elsif word_does_not_use_centre_letter?
        set_error(:word_does_not_use_centre_letter)
      else
        board.submitted_words.create!(dictionary_entry: dictionary_entry)
      end
    rescue ActiveRecord::RecordNotFound
      set_error(:word_is_not_in_dictionary)
    end
  end

  def has_word_been_submitted?(dictionary_entry)
    board.submitted_words.map { |submitted_word| submitted_word.dictionary_entry }.include?(dictionary_entry)
  end

  def word_does_not_use_centre_letter?
    centre_letter = @board.dictionary_entry.word[@board.centre_letter_offset]

    @word_to_submit.exclude?(centre_letter)
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

  # TODO set is wrong, add or even just error() could be
  def set_error(symbol)
    @errors << ERROR_MESSAGES[symbol]
  end
end

