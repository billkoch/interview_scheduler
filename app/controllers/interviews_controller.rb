class InterviewsController < ApplicationController
  def show
    @interviews = Interview.all
    respond_to do |format|
      format.html
      format.json {render json: @interviews}
    end
  end

  def show_unassigned
    @unassigned_interviews = Interview.get_unscheduled
    respond_to do |format|
      format.json
      format.html
    end
  end

  def show_assigned
    @assigned_interviews = Interview.get_scheduled
    respond_to do |format|
      format.json
    end
  end

  def unassign
    interview = Interview.find(params['id'])
    interview.interviewee = nil
    interview.save
    WebsocketRails[:interviewee_class].trigger(:schedule, interview)
    render :text => "OK"
  end

  def assign
    interview = Interview.find(params['interview_id'])
    interviewee = Interviewee.find(params['interviewee_id'])

    interviewee.interviews << interview unless interview.nil?

    render :text => "OK"
  end

  def new
    respond_to do |format|
      format.html
    end
  end

  def create
    position = Position.where("title = ?", params['position']).first
    Interview.create({scheduled_at: params['scheduled_at'], room: params['room'], position: position, a_class: params['a_class']})
    puts session[:password]
    render action: 'show_unassigned'
  end
end
