class CosmosRouter extends Backbone.Router
  initialize: (options) ->
    new app.AppView collection: app.Tracks
    @tracks = new app.Tracks
    @tracks.reset options.tracks
    app.tracks = @tracks

  routes:
    '': 'root'
    'tracks/:id': 'showTrack'

  root: ->
    new app.TracksView collection: @tracks

  showTrack: (id) ->
    track = @tracks.get(id)
    trackView = new app.TrackView model: track
    $("#tracks").empty()
    $("#tracks").html trackView.render().el

@app = window.app ? {}
@app.CosmosRouter = CosmosRouter
