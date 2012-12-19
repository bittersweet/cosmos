class Track extends Backbone.Model
  url: '/tracks'
  getAudioURL: (callback) ->
    callback(@get('file'))

@app = window.app ? {}
@app.Track = Track
