class ApplicationController < ActionController::Base
  before_action :locale_from_request!

  protected

  def require_login
    authenticate_user!
  end

  private

  def locale_from_request!
    I18n.locale = locale_from_request
  end

  def locale_from_request
    return I18n.default_locale unless request.headers.key?('HTTP_ACCEPT_LANGUAGE')

    string = request.headers.fetch('HTTP_ACCEPT_LANGUAGE')
    locale = AcceptLanguage.parse(string).match(*I18n.available_locales)

    # If the server cannot serve any matching language,
    # it can theoretically send back a 406 (Not Acceptable) error code.
    # But, for a better user experience, this is rarely done and more
    # common way is to ignore the Accept-Language header in this case.
    return I18n.default_locale if locale.nil?

    locale
  end
end
