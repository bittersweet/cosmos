class AddWaveformToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :waveform, :string
  end
end
