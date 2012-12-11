class Tracks extends Backbone.Collection
  model: app.Track
  url: ->
    '/tracks'

@app = window.app ? {}
@app.Tracks = Tracks
