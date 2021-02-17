class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]

  def show; end

  def new; end

  def edit; end

  def create
    @answer = current_user.answers.new(answer_params)
    @answer.question = question

    flash[:notice] = if @answer.save
                       'Your answer successfully created.'
                     else
                       "Answer can't be blank."
                     end

    redirect_to @answer.question
  end

  def update
    if author? && answer.update(answer_params)
      redirect_to answer
    else
      render :edit
    end
  end

  def destroy
    if author?
      answer.destroy
      redirect_to answer.question, notice: 'Your answer was successfully deleted.'
    else
      flash.now[:notice] = "You cant't delete someone else's question"
    end
  end

  private

  def author?
    current_user == answer.user
  end

  def answer
    @answer ||= params[:id] ? Answer.find(params[:id]) : question.answers.new
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  helper_method :answer, :question, :author?

  def answer_params
    params.require(:answer).permit(:body)
  end
end
