###
 * Description or Responsability
 *
 * @namespace KINOUT
 * @class Boot
 *
 * @author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###

KINOUT.Constants =

    MARKUP:
        GLOW: "<div class=\"glow\"></div>"
        COPYRIGHT: "<div class=\"copyright\">Made with <a href=\"http://tapquo.com/kinout/\">Kinout</a> by Tapquo Inc.</div>"
        PROGRESS: "<progress value='0' max='100'><span></span></progress>"
        PROGRESS_VERTICAL: "<progress class='vertical' value='0' max='100'><span></span></progress>"

    SELECTOR:
        SLIDE: ".kinout>section"
        SUBSLIDE: ".kinout>section.present>article"

        STEP: "section.present > article.present [data-step]"
        STEP_TO_SHOW: ":not([data-run='success'])"
        STEP_TO_HIDE: "[data-run='success']"

        PROGRESS: ".kinout>progress span"
        PROGRESS_VERTICAL: ".kinout>progress.vertical span"

    STYLE:
        PAST: "past"
        PRESENT: "present"
        FUTURE: "future"