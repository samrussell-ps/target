class SubmittedWordController < ApplicationController
  def create
    submit_word
    
    route_to_board
  end

  private

  def submit_word
    word_submitter.call

    set_errors
  end

  def word_submitter
    @word_submitter ||= SubmitWord.new(board, word_to_submit)
  end

  def word_to_submit
    params[:word]
  end

  def board
    @board ||= Board.find(params[:board_id])
  end

  def set_errors
    # TODO replace .first with .join('\n')
    flash[:alert] = word_submitter.errors.first unless word_submitter.errors.empty?
  end

  def route_to_board
    redirect_to controller: 'board', action: 'show', id: params[:board_id]
  end
end
