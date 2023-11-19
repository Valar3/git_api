# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  before_action :authenticate_user!

  private

  def authenticate_user!
    return if current_user

    redirect_to login_path, alert: 'Please log in to view your dashboard.'
  end
end
