class ApplicationController < ActionController::Base
  helper_method :admin?
  helper_method :manager?
  before_filter :authorize

  def admin?
    !(session[:password].nil? && session[:manager].nil?)
  end

  def manager?
    !session[:manager].nil?
  end

  def authorize
    unless admin?
      redirect_to home_admin_url
    end
  end
end
