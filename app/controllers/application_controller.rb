class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  helper_method :page_title, :login_user, :admin?

  private
  def default_url_options(options = {})
    { locale: I18n.locale }
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def check_admin
    redirect_to root_path, alert: t('notice.not_permitted') unless admin?
  end

  def page_title
    nil
  end

  def login_user
    session[:user_id] ? User.find(session[:user_id]) : nil
  end

  def admin?(user = login_user)
    user && user.provider == "twitter" && user.uid == "5645362"
  end
end
