class CreateBoard
  NUMBER_OF_RANDOM_SEEDS = 10000
  NUMBER_OF_LETTERS_IN_WORD = 9

  def call
    dictionary_word = DictionaryWord.seed_word

    Board.create!(dictionary_word: dictionary_word,
                  word_shuffle_seed: rand(NUMBER_OF_RANDOM_SEEDS),
                  centre_letter_offset: rand(NUMBER_OF_LETTERS_IN_WORD))
  end
end
