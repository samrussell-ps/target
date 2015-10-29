class BoardController < ApplicationController
  def index
  end

  def show
  end

  def create
    new_board = CreateBoard.new.call

    redirect_to new_board
  end
end
