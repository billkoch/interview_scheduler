class IntervieweesController < ApplicationController
  skip_before_filter :authorize

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

  def edit
    puts params
    @interviewee = Interviewee.find(params[:interviewee])
    respond_to do |format|
      format.html
    end
  end

  def update
    interviewee = Interviewee.find(params['id'])
    position = Position.where("title = ?", params['position']).first
    interview = Interview.next_interview_for_position(position.id, Time.now + 5.minutes)

    interviewee.interviews << interview unless interview.nil?
    redirect_to edit_interviewees_url(interviewee: interviewee.id)
  end

  def schedule
    interviewee = Interviewee.new(params['interviewee'])

    unless (BlacklistedEmail.is_blacklisted?(params['interviewee']['email']))
      position = Position.where("title = ?", params['position']).first

      if interviewee.save
        interview = Interview.next_interview_for_position(position.id, Time.now + 5.minutes)
        interviewee.interviews << interview unless interview.nil?
        redirect_to edit_interviewees_url(interviewee: interviewee.id)
      else
        flash[:error] = interviewee.errors
        render action: 'new'
      end
    else
      if interviewee.save
        position = Position.where("title = ?", 'Unassigned').first
        interview = Interview.next_interview_for_position(position.id, Time.now)
        interviewee.interviews << interview unless interview.nil?
        redirect_to edit_interviewees_url(interviewee: interviewee.id)
      else
        flash[:error] = interviewee.errors
        render action: 'new'
      end
    end
  end
end
