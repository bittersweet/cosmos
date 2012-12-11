class CosmosRouter extends Backbone.Router
  initialize: (options) ->
    new app.AppView collection: app.Tracks
    @tracks = new app.Tracks
    @tracks.reset options.tracks

  routes:
    '': 'root'

  root: ->
    new app.TracksView collection: @tracks

@app = window.app ? {}
@app.CosmosRouter = CosmosRouter
