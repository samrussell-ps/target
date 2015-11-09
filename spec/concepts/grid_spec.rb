require 'rails_helper'

describe Grid do
  let(:seed_word) { "ABCDEFGHI" }
  let(:centre_letter_offset) { seed_word.index("C") }
  let(:word_shuffle_seed) { 234 }
  subject(:grid) { Grid.new(seed_word, centre_letter_offset, word_shuffle_seed) }

  describe '#rows' do
    it 'shuffles the word and puts the centre letter in the centre' do
      rows = grid.rows

      centre_cell = rows[1][1]

      non_centre_cells = rows[0] + rows[2] + [rows[1][0]] + [rows[1][2]]

      expect(centre_cell.letter).to eq('C')

      expect(non_centre_cells.map {|x| x.letter }.sort).to eq(%w(A B D E F G H I))
    end
  end
end
