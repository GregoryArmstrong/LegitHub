class RepositoriesController < ApplicationController

  def index
    @presenter = Presenter.new(current_user)
    @params = params
  end

end
