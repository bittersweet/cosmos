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
    @model.on "player:bytesLoaded", @log

  played: =>
    console.log "playing"

  paused: =>
    console.log "paused"

  stopped: =>
    console.log "stopped"

  log: =>
    console.log "LOG"

  updatePosition: (sound) =>
    @model.waveform.redraw()
    return unless sound?

  events: ->
    'click a': 'playTrack'

  playTrack: (event) ->
    event.preventDefault()
    if app.player.playable == @model
      app.player.toggle()
    else
      app.player.load @model

  render: ->
    $(@el).html @template.render(@model.toJSON())
    $.getJSON "/tracks/#{@model.id}/waveform.json", (data) =>
      @model.waveform = new Waveform
        container: @$('.waveform')[0],
        innerColor: "#333",
        data: data
    @

@app = window.app ? {}
@app.player = new Backbone.SoundManager2(autoPlay: true)
@app.AppView = AppView
@app.TracksView = TracksView
