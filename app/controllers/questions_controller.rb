class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @questions = Question.all
  end

  def show
    @answer = question.answers.new
  end

  def new; end

  def edit; end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    if author? && question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    if author?
      question.destroy
      redirect_to questions_path, notice: 'Your question was successfully deleted.'
    else
      flash.now[:notice] = "You cant't delete someone else's question"
    end
  end

  private

  def author?
    current_user == question.user
  end

  def question
    @question ||= params[:id] ? Question.find(params[:id]) : Question.new
  end

  helper_method :question, :author?

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
