###
 * Description or Responsability
 *
 * @namespace KINOUT
 * @class View
 *
 * @author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###

KINOUT.View = ((knt, $$, undefined_) ->

    SELECTOR = knt.Constants.SELECTOR
    MARKUP = knt.Constants.MARKUP
    STYLE = knt.Constants.STYLE

    _index = knt.index

    _steps = []
    _el =
        slides: []
        progress: undefined
        progress_vertical: undefined

    init = (config) ->
        el = $$(".kinout")

        _el.slides = el.children('section')

        el.append(MARKUP.PROGRESS).append(MARKUP.PROGRESS_VERTICAL)
        _el.progress = $$(SELECTOR.PROGRESS)
        _el.progress_vertical = $$(SELECTOR.PROGRESS_VERTICAL)
        el.addClass(config.template) if config.template

        #@todo: Enable navigation trick
        #$$("body").prepend(MARKUP.GLOW + MARKUP.COPYRIGHT)
        return


    slide = (horizontal, vertical, next_step = true) ->
        unless _availableSteps(next_step)
            _saveNewIndexes horizontal, vertical
            _updateSlideIndexes()
            knt.Url.write _index.horizontal, _index.vertical
        return

    _availableSteps = (next_step) -> if (next_step) then _nextStep() else _previousStep()

    _nextStep = () ->
        available = false

        _steps = $$(SELECTOR.STEP + SELECTOR.STEP_TO_SHOW)
        for element in _steps
            step = $$(element)
            unless step.data("run") is "success"
                step.data("run", "success")
                available = true
                break
        available

    _previousStep = () ->
        available = false

        _steps = $$(SELECTOR.STEP + SELECTOR.STEP_TO_HIDE)
        i = _steps.length
        while i > 0
            step = $$(_steps[i-1])
            if step.data("run") is "success"
                step.data("run", "")
                available = true
                break
            i--
        available

    index = ->
        'horizontal': _index.horizontal
        'vertical': _index.vertical

    _saveNewIndexes = (horizontal, vertical) ->
        _index.horizontal = (if horizontal is `undefined` then _index.horizontal else horizontal)
        _index.vertical = (if vertical is `undefined` then _index.vertical else vertical)
        return

    _updateSlideIndexes = ->
        _index.horizontal = _updateSlides(SELECTOR.SLIDE, _index.horizontal)
        _index.vertical = _updateSlides(SELECTOR.SUBSLIDE, _index.vertical)
        _updateProgress()
        return

    _updateProgress = ->
        horizontal_progess = parseInt( (_index.horizontal * 100) / (_el.slides.length - 1))
        window.requestAnimationFrame ->
            _el.progress.style('width', "#{horizontal_progess}%")

        articles =  $$(_el.slides[_index.horizontal]).children('article');
        if articles.length > 0
            vertical_progress = parseInt( ((_index.vertical + 1) * 100) / articles.length)
            window.requestAnimationFrame ->
                _el.progress_vertical.style('height', "#{vertical_progress}%")
        else
            window.requestAnimationFrame ->
                _el.progress_vertical.style('height', "0%")

    _updateSlides = (selector, index) ->
        slides = Array::slice.call(document.querySelectorAll(selector))
        if slides.length
            index = Math.max(Math.min(index, slides.length - 1), 0)
            #window.requestAnimationFrame ->
            render slides, index
        else
            index = 0
        index

    render = (slides, index) ->
        slides[index].setAttribute "class", STYLE.PRESENT
        slides.slice(0, index).map (element) ->
            element.setAttribute "class", STYLE.PAST
        slides.slice(index + 1).map (element) ->
            element.setAttribute "class", STYLE.FUTURE

    init: init
    slide: slide
    index: index
    render: render

)(KINOUT, Quo)