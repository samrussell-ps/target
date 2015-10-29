require 'rails_helper'

RSpec.describe SubmittedWordController, type: :controller do
  let(:board) { Board.create!(dictionary_entry: DictionaryEntry.order("RANDOM()").first, word_shuffle_seed: 234) }

  describe 'PUT /board/1/submitted_word' do
    subject { response }

    render_views

    context 'with valid board, SubmitWord has no errors' do
      let(:mock_submit_word) { instance_double("SubmitWord") }

      before do
        allow(SubmitWord).to receive(:new).and_return(mock_submit_word)
        allow(mock_submit_word).to receive(:call).and_return(true)
        allow(mock_submit_word).to receive(:errors).and_return([])
      end

      it 'calls SubmitWord.new.call' do
        expect(mock_submit_word).to receive(:call).and_return(true)

        put :create, board_id: board.id, word: 'camel'
      end

      it 'redirects to the board with no flash' do
        put :create, board_id: board.id, letter: 'camel'

        expect(response).to redirect_to controller: :board, action: :show, id: board.id
      end
    end

    context 'with valid board, SubmitWord has one error' do
      let(:mock_submit_word) { instance_double("SubmitWord") }
      let(:expected_error_message) { "DANGER WILL ROBINSON" }

      before do
        allow(SubmitWord).to receive(:new).and_return(mock_submit_word)
        allow(mock_submit_word).to receive(:call).and_return(false)
        allow(mock_submit_word).to receive(:errors).and_return([expected_error_message])
      end

      it 'calls SubmitWord.new.call' do
        expect(mock_submit_word).to receive(:call).and_return(false)

        put :create, board_id: board.id, letter: 'camel'
      end

      it 'redirects to the board with flash' do
        put :create, board_id: board.id, letter: 'camel'

        expect(response).to redirect_to controller: :board, action: :show, id: board.id
        expect(flash[:alert]).to eq(expected_error_message)
      end
    end

    context 'with invalid board, valid guess' do
      let(:invalid_board_id) { 99999 }

      it 'explodes with great prejudice' do
        expect { put :create, board_id: invalid_board_id, letter: 'camel' }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
