class BoardPresenter
  Cell = Struct.new(:letter, :centre)

  def initialize(board)
    @board = board
  end

  def grid
    all_letters = @board.dictionary_entry.word.chars

    centre_letter = all_letters.delete_at(@board.centre_letter_offset)

    other_letters = all_letters

    shuffled_other_letters = other_letters.shuffle(random: Random.new(@board.word_shuffle_seed))

    # wtf

    grid_letters = [
      shuffled_other_letters[0..2],
      [ shuffled_other_letters[3], centre_letter, shuffled_other_letters[4] ],
      shuffled_other_letters[5..7]
    ]
  end

  def words
    @board.submitted_words.map { |submitted_word| submitted_word.dictionary_entry.word }
  end

  def score
    words.size
  end

  def maximum_score
    ValidWords.new(@board).call.size
  end

  def id
    @board.id
  end
end
