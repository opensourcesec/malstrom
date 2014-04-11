class Admin::AdminController < ApplicationController
  layout "admin"
  before_filter :authenticate_user!
  def current_ability
    @current_ability ||= AdminAbility.new(current_user)
  end

end
