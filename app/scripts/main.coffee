init = (error, geo) ->
    scheme = colorbrewer.YlOrRd[9]

    color = (country)->
        scheme[Math.floor(Math.random() * scheme.length)]

    map.init geo, {colorize: color}
    map.draw()


queue()
    .defer(d3.json, 'geo/countries.topo.json')
    .await(init)