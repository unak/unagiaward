class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.where(provider: auth['provider'], uid: auth['uid']).first || User.create_with_auth(auth)
    session[:user_id] = user.id
    redirect_to session[:previous] ? session.delete(:previous) : root_url, notice: t('notice.signedin')
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: t('notice.signedout')
  end
end
