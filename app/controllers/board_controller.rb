class BoardController < ApplicationController
  def show
    @board = Board.find(board_id)
  end

  def index
    @boards = Board.all
  end

  def create
    new_board = CreateBoard.new.call

    redirect_to new_board
  end

  private

  def board_id
    params[:id]
  end
end
