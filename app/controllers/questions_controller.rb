class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  helper_method :question

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
    question
  end

  def new; end

  def edit
    render :show, notice: "You can't edit someone else's question" unless current_user.author?(question)
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    @questions = Question.all
    if current_user.author?(question)
      question.update(question_params)
    end
  end

  def destroy
    if current_user.author?(question)
      question.destroy
      flash[:notice] = 'Your question was successfully deleted.'
    else
      flash[:notice] = "You cant't delete someone else's question"
    end
    redirect_to questions_path
  end

  private

  def question
    @question ||= params[:id] ? Question.find(params[:id]) : Question.new
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
