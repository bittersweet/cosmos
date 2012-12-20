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
    image = ChunkyPNG::Image.from_file("./doc/output2.png")
    peaks = []
    (0..1799).each do |column|
      pixels = image.column(column).first(140)

      pixels.each_with_index do |pixel, index|
        if pixel > 0
          peaks << index
          break
        end
      end
    end

    converted_peaks = []
    peaks.each do |peak|
      result = 1 - (peak / 140.0)
      converted_peaks << result
    end
    render :json => converted_peaks
  end
end
