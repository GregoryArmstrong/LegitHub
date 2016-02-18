class CommitsController < ApplicationController

  def index
    @presenter = Presenter.new(current_user)
  end

end
