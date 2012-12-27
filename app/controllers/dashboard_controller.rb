class DashboardController < ApplicationController
  def index
    @tracks = Track.ordered
  end
end
