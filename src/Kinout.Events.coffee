KINOUT.Events = ((knt, undefined_) ->
  EVENTS =
    KEYDOWN: "keydown"
    CLICK: "click"
    TOUCH: "touchstart"
    HASHCHANGE: "hashchange"

  DIRECTION =
    LEFT: "left"
    RIGHT: "right"
    UP: "up"
    DOWN: "down"

  init = ->
    _subscribeEvents()

  _subscribeEvents = ->
    document.addEventListener EVENTS.KEYDOWN, _onKeyDown, false
    document.addEventListener EVENTS.TOUCH, _onTouch, false
    document.addEventListener EVENTS.CLICK, _onClick, false
    window.addEventListener EVENTS.HASHCHANGE, _onHashChange, false

  _onKeyDown = (event) ->
    if event.keyCode >= 37 and event.keyCode <= 40
      _analizeKeyEvent event
      event.preventDefault()

  _onTouch = (event) ->
    if event.touches.length is 1
      event.preventDefault()
      point =
        x: event.touches[0].clientX
        y: event.touches[0].clientY

      _analizePoint point

  _onClick = (event) ->
    event.preventDefault()
    point =
      x: event.clientX
      y: event.clientY

    _analizePoint point

  _onHashChange = ->
    knt.Url.read()

  _analizeKeyEvent = (event) ->
    switch event.keyCode
      when 37
        knt.Router.direction DIRECTION.LEFT
      when 39
        knt.Router.direction DIRECTION.RIGHT
      when 38
        knt.Router.direction DIRECTION.UP
      when 40
        knt.Router.direction DIRECTION.DOWN

  _analizePoint = (point) ->
    window_width = window.innerWidth * 0.3
    window_height = window.innerHeight * 0.3
    if point.x < window_width
      knt.Router.direction DIRECTION.LEFT
    else if point.x > window.innerWidth - window_width
      knt.Router.direction DIRECTION.RIGHT
    else if point.y < window_height
      knt.Router.direction DIRECTION.UP
    else knt.Router.direction DIRECTION.DOWN  if point.y > window.innerHeight - window_height

  init: init
)(KINOUT)