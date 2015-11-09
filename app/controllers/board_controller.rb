class BoardController < ApplicationController
  def show
    board = Board.find(board_id)
    @board_presenter = BoardPresenter.new(board)
  end

  def index
    @boards = Board.all
  end

  def create
    redirect_to CreateBoard.new.call
  end

  private

  def board_id
    params[:id]
  end
end
