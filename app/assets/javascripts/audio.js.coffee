soundManager.setup
  url: '/soundmanager2.swf'
  debugMode: false

$ ->
  $('#tracks').on 'click', 'a', (event) ->
    event.preventDefault()
    console.log $(@)
    window.currentTrack = soundManager.createSound
      id: 'track1'
      url: $(@).attr("href")

    window.currentTrack.play()


