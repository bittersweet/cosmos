soundManager.setup
  url: '/soundmanager2.swf'
  debugMode: false

$ ->
  $('.track a').click (event) ->
    event.preventDefault()
    console.log $(@)
    window.currentTrack = soundManager.createSound
      id: 'track1'
      url: $(@).attr("href")

    window.currentTrack.play()


