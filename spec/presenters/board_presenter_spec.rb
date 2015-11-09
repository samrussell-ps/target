require 'rails_helper'

describe BoardPresenter do
  let(:seed_word) { "ABCDEFGHI" }
  let(:word_shuffle_seed) { 234 }
  let(:centre_letter_offset) { seed_word.index('C') }
  let(:mock_dictionary_word) { instance_double("DictionaryWord") }
  let(:mock_board) { instance_double("Board") }
  let(:board_presenter) { BoardPresenter.new(mock_board) }

  describe '#rows' do
    it 'shuffles the word and puts the centre letter in the centre' do
      allow(mock_board).to receive(:dictionary_word).and_return(mock_dictionary_word)
      allow(mock_board).to receive(:centre_letter_offset).and_return(centre_letter_offset)
      allow(mock_board).to receive(:word_shuffle_seed).and_return(word_shuffle_seed)
      allow(mock_dictionary_word).to receive(:word).and_return(seed_word)

      rows = board_presenter.rows

      centre_cell = rows[1][1]

      non_centre_cells = rows[0] + rows[2] + [rows[1][0]] + [rows[1][2]]

      expect(centre_cell.letter).to eq('C')

      expect(non_centre_cells.map {|x| x.letter }.sort).to eq(%w(A B D E F G H I))
    end
  end

  describe '#words' do
    let(:words) { ["CAT", "DOG", "MOUSE" ] }
    let(:submitted_words) {
      words.map do |word|
        submitted_word = instance_double("SubmittedWord")
        allow(submitted_word).to receive(:dictionary_word).and_return(DictionaryWord.find_by_word(word))

        submitted_word
      end
    }

    it 'returns the words that have been submitted' do
      allow(mock_board).to receive(:submitted_words).and_return(submitted_words)

      expect(board_presenter.words).to contain_exactly(*words)
    end
  end

  describe '#score' do
    let(:words) { ["CAT", "DOG", "MOUSE" ] }
    let(:submitted_words) {
      words.map do |word|
        submitted_word = instance_double("SubmittedWord")
        allow(submitted_word).to receive(:dictionary_word).and_return(DictionaryWord.find_by_word(word))

        submitted_word
      end
    }

    it 'is the number of words that have been guessed' do
      allow(mock_board).to receive(:submitted_words).and_return(submitted_words)

      expect(board_presenter.score).to eq(words.size)
    end
  end

  describe '#maximum_score' do
    let(:maximum_score) { 5 }

    it 'returns the maximum score' do
      allow(ValidWords).to receive(:new).and_return( Proc.new { [*0...maximum_score] } )

      expect(board_presenter.maximum_score).to eq(maximum_score)
    end
  end

  describe '#id' do
    it 'returns board id' do
      expect(mock_board).to receive(:id).and_return(1337)

      expect(board_presenter.id).to eq(1337)
    end
  end
end
