require 'rails_helper'

describe CreateBoard do
  it 'creates a board' do
    expect { CreateBoard.new.call }.to change { Board.count }.by(1)
  end

  it 'only creates boards with 9 letter words' do
    boards = 3.times.map { CreateBoard.new.call.dictionary_word.word.length }
    expect(boards).to eq(3.times.map { 9 })
  end
end
