class PagesController < ApplicationController
  include HighVoltage::StaticPage

  def index
    authorize :page

    if current_user
      authorize Meal

      @meals = policy_scope(Meal)
      @diets = @meals.select(:category)
    #   redirect_to dashboard_path
    end
  end
end
