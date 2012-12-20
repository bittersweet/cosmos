class Waveform
  attr_accessor :track

  def initialize(track)
    @track = track
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
