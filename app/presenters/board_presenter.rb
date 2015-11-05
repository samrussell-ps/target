class BoardPresenter
  Cell = Struct.new(:letter, :centre)

  def initialize(board)
    @board = board
  end

  def grid
    all_letters = @board.dictionary_entry.word.chars

    centre_cell = Cell.new(all_letters.delete_at(@board.centre_letter_offset), true)

    other_cells = all_letters.map { |x| Cell.new(x, false) }

    shuffled_other_cells = other_cells.shuffle(random: Random.new(@board.word_shuffle_seed))

    shuffled_cells = shuffled_other_cells.insert(shuffled_other_cells.length/2, centre_cell)

    grid_letters = shuffled_cells.each_slice(3).to_a
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
