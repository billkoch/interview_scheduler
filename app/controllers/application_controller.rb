class ApplicationController < ActionController::Base
  helper_method :admin?
  before_filter :authorize

  def admin?
    !session[:password].nil?
  end

  def authorize
    unless admin?
      redirect_to home_admin_url
    end
  end
end
