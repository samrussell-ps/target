class WordValidator
  attr_reader :errors

  def initialize(board, word)
    @board = board
    @word = word
    @errors = []
  end

  def call
    test_word

    @errors.empty?
  end

  private

  def test_word
    dictionary_entry = DictionaryEntry.find_by_word(word_to_submit)

    if dictionary_entry.nil?
      errors << :word_is_not_in_dictionary
    elsif !is_word_in_grid?
      errors << :word_is_not_in_grid
    elsif word_does_not_use_centre_letter?
      errors << :word_does_not_use_centre_letter
    end
  end

  def word_to_submit
    @word_to_submit ||= @word.to_s.upcase
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
end
