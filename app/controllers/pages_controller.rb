class PagesController < ApplicationController
  include HighVoltage::StaticPage

  def index
    authorize :page

    # if current_user
    #   redirect_to dashboard_path
    # end
  end
end
