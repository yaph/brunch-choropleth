map =
    geo: null
    conf: {}

    defaults:
        width: 960
        height: 580
        selector: '#map'
        colorize: null

    init: (geo, conf)->
        map.geo = geo
        for key, val of map.defaults
            if conf.hasOwnProperty key
                map.conf[key] = conf[key]
            else
                map.conf[key] = val

    draw: ()->
        projection = d3.geo.naturalEarth()
            .scale(map.conf.width / 5)
            # hide most of Antarctica and move a little to the left
            .translate([(map.conf.width / 2.2), (map.conf.height / 1.7)])
            .precision(.1)

        map.path = d3.geo.path()
            .projection(projection);

        map.svg = d3.select(map.conf.selector).append('svg')
            .attr('width', map.conf.width)
            .attr('height', map.conf.height)

        svg_countries = map.svg.append('g')
            .attr('class', 'countries')
            .selectAll('path')
            .data(topojson.feature(map.geo, map.geo.objects.subunits).features)

        svg_countries.enter().append('path')
            .attr('class', 'country')
            .style('fill', (d)-> map.conf.colorize d)
            .attr('d', map.path)
            .append('title')
                .text((d)-> d.properties.name)

        mesh = topojson.mesh(map.geo, map.geo.objects.subunits, (a, b)-> a != b)
        map.svg.insert('path')
            .datum(mesh)
            .attr('class', 'boundary')
            .attr('d', map.path)
