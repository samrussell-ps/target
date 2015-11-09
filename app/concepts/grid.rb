class Grid
  Cell = Struct.new(:letter, :centre)

  def initialize(seed_word, centre_letter_offset, word_shuffle_seed)
    @seed_word = seed_word
    @centre_letter_offset = centre_letter_offset
    @word_shuffle_seed = word_shuffle_seed
  end

  def rows
    shuffled_cells.each_slice(3).to_a
  end

  private

  def shuffled_cells
    shuffled_cells = shuffled_other_cells.insert(shuffled_other_cells.length/2, centre_cell)
  end

  def shuffled_other_cells
    other_cells = other_letters.map { |letter| Cell.new(letter, false) }

    other_cells.shuffle(random: Random.new(@word_shuffle_seed))
  end

  def other_letters
    all_letters = @seed_word.chars


    all_letters.delete_at(@centre_letter_offset)

    all_letters
  end

  def centre_cell
    Cell.new(centre_letter, true)
  end

  def centre_letter
    @seed_word.chars[@centre_letter_offset]
  end
end
