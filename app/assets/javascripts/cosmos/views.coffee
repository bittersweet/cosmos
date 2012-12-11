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
  events: ->
    'click a': 'playTrack'
  playTrack: (event) ->
    event.preventDefault()
    window.currentTrack = soundManager.createSound
      id: @model.get('filename')
      url: @model.get('file')
    window.currentTrack.play()

  render: ->
    $(@el).html @template.render(@model.toJSON())
    @

@app = window.app ? {}
@app.AppView = AppView
@app.TracksView = TracksView
