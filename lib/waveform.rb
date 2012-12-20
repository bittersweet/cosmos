class Waveform
  attr_accessor :track

  def initialize(track)
    @track = track
  end

  def analyze
    image = ChunkyPNG::Image.from_file(@track.waveform.path)
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
    converted_peaks
  end

  def generate_waveform
    file = @track.file.path
    filename = Rails.root + "tmp/#{@track.id}-waveform.png"
    `waveform --width 1800 --height 280 --color-bg 00000000 --color-center 000000ff --color-outer 000000ff #{file} #{filename}`
    output_file = File.open(filename)
    @track.waveform = output_file
    @track.save
  end
end
