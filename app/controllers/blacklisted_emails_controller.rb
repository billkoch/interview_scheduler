class BlacklistedEmailsController < ApplicationController
  def show
    respond_to do |format|
      format.html
    end
  end

  def create
    @email = BlacklistedEmail.new(params['blacklist'])
    if @email.save
      redirect_to blacklisted_emails_url
    else
      flash[:error] = email.errors
      render action: 'new'
    end
  end

  def new
    respond_to do |format|
      format.html
    end
  end
end
