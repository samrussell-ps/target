require 'rails_helper'

describe CreateBoard do
  it 'creates a board' do
    expect { CreateBoard.new.call }.to change { Board.count }.by(1)
  end

  it 'only creates boards with 9 letter words' do
    boards = 3.times.map { CreateBoard.new.call.dictionary_entry.word.length }
    expect(boards).to eq(3.times.map { 9 })
  end

  it 'sets maximum_score to the number of valid words' do
    board = CreateBoard.new.call
    expect(board.maximum_score).to eq(board.valid_words.size)
  end
end
