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
    position = Position.where("title = ?", params['position']).first
    Interview.create({scheduled_at: params['scheduled_at'], room: params['room'], position: position})
    puts session[:password]
    render action: 'show'
  end
end
