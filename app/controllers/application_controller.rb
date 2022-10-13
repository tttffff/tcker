class ApplicationController < ActionController::Base
    before_action :authenticate_user!, unless: :devise_controller?
    include Pundit::Authorization
    after_action :verify_authorized, except: :index, unless: :devise_controller?
    after_action :verify_policy_scoped, only: :index, unless: :devise_controller?
end
