class CreateBoard
  NUMBER_OF_RANDOM_SEEDS = 10000

  def call
    Board.create!(dictionary_entry: DictionaryEntry.random, word_shuffle_seed: rand(NUMBER_OF_RANDOM_SEEDS))
  end
end
