class CurrentContext
  attr_reader :user, :params

  def initialize(user, params)
    @user = user
    @params = params
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Pundit
  # after_action :verify_authorized

  before_action :check_params

  rescue_from ActionController::RoutingError, with: :route_not_found
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::AssociationTypeMismatch, with: :request_formed_unproperly
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  before_action :set_current_user
  def set_current_user
    unless current_user
      @current_user ||= doorkeeper_token ? User.find(doorkeeper_token.resource_owner_id) : nil
    end
  end

  def pundit_user
    CurrentContext.new(current_user, params)
  end

  def redirect_to_safe_place
    redirect_to(
      if request.referer and URI(request.referer).path != request.path
        request.referer
      else
        root_path
      end)
  end

  public def route_not_found
    flash[:alert] = "This route does not seems to lead anywhere, sorry for the inconvenience."
    redirect_to_safe_place
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to_safe_place
  end

  def check_params
    types = {
      page: ActionController::Parameters,
      filter: ActionController::Parameters,
      sort: String
    }
    types.each do |parameter, type|
      if params[parameter].present? && !(params[parameter].is_a? type)
        raise ActionController::BadRequest
      end
    end
  end

  def record_not_found
    record_message = "this record"
    record_message = "the #{params["controller"].singularize} with id: #{params["id"]}" if params.key? "controller" and params.key? "id"
    flash[:alert] = "Couldn't find #{record_message}."
    redirect_to_safe_place
  end

  def request_formed_unproperly
    errors = ActiveModel::Errors.new(nil)
    errors.add(:app, I18n.t('errors.bad_request'))
    render json: errors, status: :bad_request and return
  end
end
