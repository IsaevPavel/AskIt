class QuestionsController < ApplicationController
  before_action :set_question!, only: %i[edit update destroy show]

  def edit
  end
  def update
    if @question.update question_params
      flash[:success] = "Question updated!"
      redirect_to questions_path
    else
      render :edit
    end
  end
  def destroy
    @question.destroy
    redirect_to questions_path
    flash[:success] = "Question deleted!"
  end
  def show
    @answer = @question.answers.build
    @answers = @question.answers.order(created_at: :desc).page(params[:page])
  end
  def index
    @questions = Question.order(created_at: :desc).page params[:page]
  end
  def new
    @question = Question.new
  end
  def create
    @question = Question.new question_params
    if @question.save
      flash[:success] = "Question created!"
      redirect_to questions_path
    else
      render :new
    end
  end
  def question_params
    params.require(:question).permit(:title, :body)
  end
  def set_question!
    @question = Question.find params[:id]
  end
end