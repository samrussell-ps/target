class ValidWords
  def initialize(board)
    @board = board
  end

  def call
    DictionaryEntry.select { |dictionary_entry| is_word_in_grid?(dictionary_entry.word) }
  end

  private

  def is_word_in_grid?(word)
    word_character_frequency(word).all? do |char, count|
      grid_character_frequency[char] >= count
    end
  end

  # TODO dedup
  def grid_character_frequency
    @board.dictionary_entry.word.chars.each_with_object(Hash.new(0)) do |char, counts|
      counts[char] += 1
    end
  end

  def word_character_frequency(word)
    word.chars.each_with_object(Hash.new(0)) do |char, counts|
      counts[char] += 1
    end
  end
end
