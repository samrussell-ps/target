require 'rails_helper'

RSpec.describe BoardController, type: :controller do
  let(:board) { Board.create!(dictionary_entry: DictionaryEntry.seed_word, word_shuffle_seed: 234, maximum_score: 1, centre_letter_offset: 1) }
  describe '#new' do
    it 'creates a new board' do
      expect { post :create }.to change { Board.count }.by(1)
    end

    context 'with the new board' do
      subject { response }

      before do
        post :create
      end

      it { is_expected.to redirect_to action: :show, id: Board.last.id }
    end
  end

  describe '#index' do
    subject { response }

    render_views

    before do
      get :index
    end

    it { is_expected.to render_template(:index) }
  end

  describe '#show' do
    let(:id_of_board_that_does_not_exist) { 99999 }

    render_views

    it 'shows board when board exists' do
      get :show, id: board.id

      expect(response).to render_template(:show)
    end

    it 'redirects to index when game does not exist' do
      expect { get :show, id: id_of_board_that_does_not_exist }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
