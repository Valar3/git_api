# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.find_or_create_by(uid: auth['uid'])
    user.email = auth['info']['email']
    user.github_access_token = auth['credentials']['token']
    user.save
    session[:user_id] = user.id
    redirect_to '/dashboard', notice: 'Logged in!'
  end

  def new; end

  def destroy
    reset_session
    redirect_to root_url, notice: 'Logged out!'
  end
end
