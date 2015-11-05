class CreateBoard
  NUMBER_OF_RANDOM_SEEDS = 10000

  def call
    dictionary_entry = DictionaryEntry.seed_word

    Board.create!(dictionary_entry: dictionary_entry,
                  word_shuffle_seed: rand(NUMBER_OF_RANDOM_SEEDS),
                  centre_letter_offset: rand(9))
  end
end
