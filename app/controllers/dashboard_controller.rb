class DashboardController < ApplicationController

  def show
    @presenter = Presenter.new(current_user)
  end

end
