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
  render: ->
    $(@el).html @template.render(@model.toJSON())
    @

@app = window.app ? {}
@app.AppView = AppView
@app.TracksView = TracksView
