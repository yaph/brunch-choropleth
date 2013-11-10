map =
    defaults:
        width: 960
        height: 580
        scheme: colorbrewer.YlOrRd[9]
        colorize: null

    init: (geo, conf)->
        console.log geo, conf

    draw: ()->
        console.log 'drawing'
