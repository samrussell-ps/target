require 'rails_helper'

describe CreateBoard do
  it 'creates a board' do
    expect { CreateBoard.new.call }.to change { Board.count }.by(1)
  end
end
