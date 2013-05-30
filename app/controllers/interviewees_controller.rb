class IntervieweesController < ApplicationController
  skip_before_filter :authorize

  def show    
    @interviewees = Interviewee.all
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    respond_to do |format|
      format.html
    end
  end

  def edit
    @interviewee = Interviewee.find(params[:interviewee])
    # flash[:notice] = @interviewee.positions.count > 5 || @interviewee.positions.count < 1 ? "You may sign up for one interview" : "You may sign up for a total of #{@interviewee.positions.count} interviews."
    # flash[:notice] = "You are done registering." unless @interviewee.is_not_booked?
    flash[:notice] = @interviewee.interviews.count < 1 ? "You may sign up for one interview" : "You are done registering."
    flash[:error] = @interviewee.interviews.count < 1 ? "" : "Please write down your interview time and location."
    respond_to do |format|
      format.html
    end
  end

  def create
    interviewee = Interviewee.new(params['interviewee'])
    if interviewee.save
      WebsocketRails[:interviewee_class].trigger(:update, interviewee)
      if admin?
        redirect_to '/interviewees'
      else
        redirect_to edit_interviewees_url(interviewee: interviewee.id)
      end
    else
      flash[:error] = interviewee.errors
      render action: 'new'
    end
  end

  def add_position
    interviewee = Interviewee.find(params['id']).add_position(Position.find(params['position_id']))
    WebsocketRails[:interviewee_class].trigger(:update, interviewee)
    render :text => "OK"
  end

  def remove_position
    interviewee = Interviewee.find(params['id']).remove_position(Position.find(params['position_id']))
    WebsocketRails[:interviewee_class].trigger(:update, interviewee)
    render :text => "OK"
  end

  def delete_user
    interviewee = Interviewee.find(params['id']).destroy
    WebsocketRails[:interviewee_class].trigger(:update, interviewee)
    render :text => "OK"
  end

  def update
    interviewee = Interviewee.find(params['id'])
    position = Position.where("title = ?", params['position']).first

    if interviewee.is_not_booked? && !interviewee.has_interview_for_position?(position)
      interview = nil
      a_class = interviewee.can_schedule_for_position(position) ? 'A' : 'B'

      if interviewee.interviews.length > 0
        interview_time = interviewee.interviews[0].scheduled_at
        interview = Interview.next_interview_for_position(position.id, Time.now, a_class, interview_time)
      else
        interview = Interview.next_interview_for_position(position.id, Time.now, a_class)
      end 

      flash[:error] = interview.nil? ? 'Sorry, there are no more positions for that position.' : ''
      interviewee.interviews << interview unless interview.nil?
      WebsocketRails[:interviewee_class].trigger(:schedule, interviewee)
    end

    redirect_to edit_interviewees_url(interviewee: interviewee.id)
  end
end
