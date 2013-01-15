class IntervieweesController < ApplicationController
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
    # Interviewee.create(params)
    redirect_to interviewees_url
  end

  def destroy
    Interviewee.destroy()
  end
end
