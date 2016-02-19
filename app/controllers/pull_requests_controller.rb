class PullRequestsController < ApplicationController

  def index
    @presenter = Presenter.new(current_user)
    @repository_owner = params[:repository_owner]
    @repository_name = params[:repository_name]
  end

end
