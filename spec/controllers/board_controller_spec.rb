require 'rails_helper'

RSpec.describe BoardController, type: :controller do
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
end
