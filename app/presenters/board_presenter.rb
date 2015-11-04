class BoardPresenter
  def initialize(board)
    @board = board
  end

  def grid
    word = @board.dictionary_entry.word
    centre_letter = word[@board.centre_letter_offset]
    other_letters = word[0...@board.centre_letter_offset] + word[@board.centre_letter_offset+1..-1]
    shuffled_letters = other_letters.chars.shuffle(random: Random.new(@board.word_shuffle_seed))
    grid_letters = [shuffled_letters[0..2],
                    [shuffled_letters[3], centre_letter, shuffled_letters[4]],
                    shuffled_letters[5..7]
    ]
  end

  def words
    @board.submitted_words.map { |submitted_word| submitted_word.dictionary_entry.word }
  end

  def score
    words.size
  end

  def maximum_score
    @board.maximum_score
  end

  def id
    @board.id
  end
end
