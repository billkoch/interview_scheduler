class InterviewsController < ApplicationController
  def show
    respond_to do |format|
      format.html
    end
  end

  def new
    respond_to do |format|
      format.html
    end
  end

  def create
    puts params
    position = Position.where("title = ?", params['position']).first
    Interview.create({scheduled_at: params['scheduled_at'], room: params['room'], position: position})
    redirect_to interviews_path
  end
end
