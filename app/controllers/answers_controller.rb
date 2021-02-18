class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]

  def show; end

  def new; end

  def edit
    unless current_user.author?(answer)
      render :show, notice: "You can't edit someone else's answer"
    end
  end

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
    if current_user.author?(answer)
      if answer.update(answer_params)
        redirect_to answer
      else
        render :edit
      end
    else
      render :show
    end
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
