class AnswersController < ApplicationController
  before_action :authenticate_user!

  def edit
    redirect_to answer.question, notice: "You can't edit someone else's answer" unless current_user.author?(answer)
  end

  def create
    @answer = current_user.answers.new(answer_params)
    @answer.question = question
    @answer.save
  end

  def update
    @answer = Answer.find(params[:id])
    @question = @answer.question
    if current_user.author?(@answer)
      @answer.update(answer_params)
    end
     # redirect_to @answer.question
  end

  def destroy
    if current_user.author?(answer)
      answer.destroy
      flash[:notice] = 'Your answer was successfully deleted.'
    else
      flash[:notice] = "You cant't delete someone else's answer"
    end
    redirect_to answer.question
  end

  private

  def answer
    @answer ||= params[:id] ? Answer.find(params[:id]) : question.answers.new
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  helper_method :answer

  def answer_params
    params.require(:answer).permit(:body)
  end
end
