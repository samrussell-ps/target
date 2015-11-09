class BoardPresenter
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
    @maximum_score ||= ValidWords.new(@board).call.size
  end

  def id
    @board.id
  end

  def rows
    Grid.new(@board.dictionary_word.word, @board.centre_letter_offset, @board.word_shuffle_seed).rows
  end
end
