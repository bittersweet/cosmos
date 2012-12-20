class TracksController < ApplicationController
  def new
    @track = current_user.tracks.new
  end

  def create
    @track = current_user.tracks.new(params[:track])
    if @track.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def waveform
    @track = Track.find(params[:id])
    waveform = Waveform.new(@track)
    render :json => waveform.analyze
  end
end
