class CreateBoard
  NUMBER_OF_RANDOM_SEEDS = 10000

  def call
    dictionary_entry = DictionaryEntry.random

    Board.create!(dictionary_entry: dictionary_entry,
                  word_shuffle_seed: rand(NUMBER_OF_RANDOM_SEEDS),
                  maximum_score: ValidWords.new(dictionary_entry.word).call.size,
                  centre_letter_offset: rand(9))
  end
end
