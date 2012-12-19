class AppView extends Backbone.View
  render: ->
    $(@el).empty()
    @

class TracksView extends Backbone.View
  el: '#tracks'
  initialize: ->
    @render()
  render: ->
    $(@el).empty()
    for track in @collection.models
      trackView = new TrackView model: track
      $(@el).append trackView.render().el
    @

class TrackView extends Backbone.View
  template: HoganTemplates['templates/track']
  className: 'track'
  initialize: ->
    @model.on "player:paused",   @paused
    @model.on "player:played",   @played
    @model.on "player:resumed",  @played
    @model.on "player:stopped",  @stopped
    @model.on "player:finished", @log
    @model.on "player:releasing", @stopped
    @model.on "player:playing", @updatePosition

  played: =>
    console.log "playing"
    $(@el).addClass("playing")

  paused: =>
    console.log "paused"
    $(@el).removeClass("playing")

  stopped: =>
    console.log "stopped"
    $(@el).removeClass("playing")

  log: =>
    console.log "LOG"

  updatePosition: (sound) =>
    console.log "update position"
    return unless sound?

    width = "#{100 * sound.position / sound.durationEstimate}%"
    @$(".bar .filler").css "width", width

  events: ->
    'click a': 'playTrack'

  playTrack: (event) ->
    event.preventDefault()
    app.player.load @model

  render: ->
    $(@el).html @template.render(@model.toJSON())
    @

@app = window.app ? {}
@app.player = new Backbone.SoundManager2(autoPlay: true)
@app.AppView = AppView
@app.TracksView = TracksView
