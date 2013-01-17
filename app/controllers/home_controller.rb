class HomeController < ApplicationController
  skip_before_filter :authorize
  def index
    respond_to do |format|
      format.html
    end
  end

  def admin
    respond_to do |format|
      format.html
    end
  end

  def login
    signin_params = params['admin']
    if signin_params['pass'].eql?('nu!tdcr3g') and signin_params['user'].eql?('lomison')
      session[:password] = signin_params["pass"]
    end
    redirect_to home_index_url
  end

  def logout
    session[:password] = nil
    redirect_to home_index_url
  end
end
