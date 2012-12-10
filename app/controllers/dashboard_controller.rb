class DashboardController < ApplicationController
  def index
    @tracks = current_user.tracks.ordered
  end
end
