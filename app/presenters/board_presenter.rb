class BoardPresenter
  Cell = Struct.new(:letter, :centre)

  def initialize(board)
    @board = board
  end

  def words
    @board.submitted_words.map { |submitted_word| submitted_word.dictionary_word.word }
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

  def grid
    grid_letters = shuffled_cells.each_slice(3).to_a
  end

  private

  def shuffled_cells
    shuffled_cells = shuffled_other_cells.insert(shuffled_other_cells.length/2, centre_cell)
  end

  def shuffled_other_cells
    other_cells = other_letters.map { |letter| Cell.new(letter, false) }

    other_cells.shuffle(random: Random.new(@board.word_shuffle_seed))
  end

  def other_letters
    all_letters = @board.dictionary_word.word.chars

    all_letters.delete_at(@board.centre_letter_offset)

    all_letters
  end

  def centre_cell
    Cell.new(centre_letter, true)
  end

  def centre_letter
    @board.dictionary_word.word.chars[@board.centre_letter_offset]
  end
end
