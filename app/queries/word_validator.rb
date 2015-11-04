class WordValidator
  attr_reader :errors

  def initialize(board, dictionary_entry)
    @board = board
    @dictionary_entry = dictionary_entry
    @errors = []
  end

  def call
    test_word

    @errors.empty?
  end

  private

  def test_word
    if @dictionary_entry.nil?
      errors << :word_is_not_in_dictionary
    elsif !is_word_in_grid?
      errors << :word_is_not_in_grid
    elsif word_does_not_use_centre_letter?
      errors << :word_does_not_use_centre_letter
    end
  end

  def word_to_submit
    @word_to_submit ||= @dictionary_entry.word
  end

  def has_word_been_submitted?
    @board.submitted_words.map { |submitted_word| submitted_word.dictionary_entry }.include?(@dictionary_entry)
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

  def grid_character_frequency
    character_frequency(@board.dictionary_entry.word)
  end

  def word_character_frequency
    character_frequency(word_to_submit)
  end

  def character_frequency(word)
    word.chars.each_with_object(Hash.new(0)) do |char, counts|
      counts[char] += 1
    end
  end
end
