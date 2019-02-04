class PagesController < ApplicationController
  include HighVoltage::StaticPage

  def index
    authorize :page

    if current_user
      authorize Meal

      @meals = Meal.all
    #   redirect_to dashboard_path
    end
  end
end
