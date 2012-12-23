class AppView extends Backbone.View
  initialize: ->
    navigationView = new NavigationView
    $("div#navigation").append navigationView.render().el

class NavigationView extends Backbone.View
  template: HoganTemplates['templates/navigation']
  events:
   'click .home': 'home'
  home: ->
    Backbone.history.navigate "", true
  render: ->
    $(@el).html @template.render()
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

  events: ->
    'click a.file': 'playTrack'
    'click .waveform': 'scrub'
    'click a.title': 'navigateToTrack'

  played: =>
    options = {meta: "#{window.currentUser.id}: #{@model.get('title')}"}
    metric.track("play", options)
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

  scrub: (event) ->
    left_offset = @$(".waveform").offset().left + 2 # bit of a magic variable, but seems to align better
    position = (event.pageX - left_offset) / 1200 # width of player
    app.player.setPosition(position)

  playTrack: (event) ->
    event.preventDefault()
    if app.player.playable == @model
      app.player.toggle()
    else
      app.player.load @model

  navigateToTrack: (event) ->
    event.preventDefault()
    Backbone.history.navigate "tracks/#{@model.id}", true

  render: ->
    $(@el).html @template.render(@model.toJSON())
    $.getJSON "/tracks/#{@model.id}/waveform.json", (data) =>
      @model.waveform = new Waveform
        container: @$('.waveform')[0]
        innerColor: "#373737"
        data: data
    @

@app = window.app ? {}
@app.player = new Backbone.SoundManager2(autoPlay: true)
@app.AppView = AppView
@app.TracksView = TracksView
@app.TrackView = TrackView
