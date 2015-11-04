class CreateBoard
  NUMBER_OF_RANDOM_SEEDS = 10000

  def call
    dictionary_entry = DictionaryEntry.seed_word

    board = Board.create!(dictionary_entry: dictionary_entry,
                  word_shuffle_seed: rand(NUMBER_OF_RANDOM_SEEDS),
                  maximum_score: 0, 
                  centre_letter_offset: rand(9))

    board.maximum_score = ValidWords.new(board).call.size

    board.save

    board
  end
end
