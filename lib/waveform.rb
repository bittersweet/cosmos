class Waveform
  attr_accessor :track

  def initialize(track)
    @track = track
  end

  def analyze
    image = ChunkyPNG::Image.from_file(@track.waveform.path)
    peaks = []
    (0..1799).each do |y|
      peaks << retrieve_peak_from_column(image.column(y))
    end

    peaks.collect do |peak|
      1 - (peak / 140.0)
    end
  end

  def generate_waveform
    file = @track.file.path
    filename = Rails.root + "tmp/#{@track.id}-waveform.png"
    `/usr/local/bin/waveform --width 1800 --height 280 --color-bg 00000000 --color-center 000000ff --color-outer 000000ff #{file} #{filename}`
    output_file = File.open(filename)
    @track.update_attributes(:waveform => output_file)
  end

  private

  def retrieve_peak_from_column(column)
    column.each_with_index do |pixel, index|
      return index if pixel > 0
    end
  end
end
