class ApplicationController < ActionController::Base
  before_action :set_i18n_locale_from_params
  include Authentication
  allow_browser versions: :modern
  include ActiveStorage::SetCurrent

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def set_i18n_locale_from_params
    if params[:set_locale]
      if I18n.available_locales.map(&:to_s).include?(params[:set_locale])
        redirect_to url_for(request.query_parameters.merge(locale: params[:set_locale], set_locale: nil))
        return
      else
        flash.now[:notice] =
          I18n.t("i18n.translation_not_available", locale: params[:set_locale])
      end
    end

    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
      I18n.locale = params[:locale]
      else
        flash.now[:notice] =
          I18n.t("i18n.translation_not_available", locale: params[:locale])
        logger.error flash.now[:notice]
      end
    end
  end
end
