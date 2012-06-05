###
 * Description or Responsability
 *
 * @namespace KINOUT
 * @class View
 *
 * @author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###

KINOUT.View = ((knt, $$, undefined_) ->

    _index =
        horizontal: 0
        vertical: 0

    MARKUP =
        GLOW: "<div class=\"glow\"></div>"
        COPYRIGHT: "<div class=\"copyright\">Made with <a href=\"http://tapquo.com/kinout/\">Kinout</a> by Tapquo Inc.</div>"

    init = (config) ->
        $$("body").prepend(MARKUP.GLOW + MARKUP.COPYRIGHT)
        $$(".kinout").addClass(config.template) if config.template

        _navigation_trick()
        return

    slide = (horizontal, vertical) ->
        _saveNewIndexes horizontal, vertical
        _updateSlideIndexes()
        knt.Url.write _index.horizontal, _index.vertical
        return

    index = -> _index

    _saveNewIndexes = (horizontal, vertical) ->
        _index.horizontal = (if horizontal is `undefined` then _index.horizontal else horizontal)
        _index.vertical = (if vertical is `undefined` then _index.vertical else vertical)
        return

    _updateSlideIndexes = ->
        _index.horizontal = _updateSlides(".kinout>section", _index.horizontal)
        _index.vertical = _updateSlides("section.present>section", _index.vertical)
        return

    _updateSlides = (selector, index) ->
        slides = Array::slice.call(document.querySelectorAll(selector))
        if slides.length
            index = Math.max(Math.min(index, slides.length - 1), 0)
            slides[index].setAttribute "class", "present"
            slides.slice(0, index).map (element) ->
                element.setAttribute "class", "past"

            slides.slice(index + 1).map (element) ->
                element.setAttribute "class", "future"
        else
            index = 0
        index

    _navigation_trick = () ->
        message = (if navigator.userAgent.match(/(iPhone|iPad|iPod|Android)/i) then "Tap to navigate" else "Navigate via keyboard")
        $$("section:first-child").append("<h4 class=\"transparent\">(" + message + ")</h4>")
        return

    init: init
    slide: slide
    index: index

)(KINOUT, Quo)