class SubmittedWordController < ApplicationController
  def create
    word_submitter = SubmitWord.new(Board.find(params[:board_id]), params[:word])

    unless word_submitter.call
      flash[:alert] = word_submitter.errors.join('\n')
    end
    
    redirect_to controller: 'board', action: 'show', id: params[:board_id]
  end
end
