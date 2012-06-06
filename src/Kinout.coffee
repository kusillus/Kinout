###
 * Description or Responsability
 *
 * @namespace KINOUT
 *
 * @author Javier Jimenez Villar <javi@tapquo.com> || @soyjavi
###

KINOUT = {
    VERSION: "0.6"

    init: (config = {}) ->
        @View.init config
        @Events.init()
        @Url.read()
        return
}

window.KINOUT = KINOUT