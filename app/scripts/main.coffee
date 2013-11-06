map =
    width: 960
    height: 580
    scheme: colorbrewer.YlOrRd[9]

    color: (country)->
        map.scheme[Math.floor(Math.random() * map.scheme.length)]

    draw: (selector, geo)->
        console.log geo
        projection = d3.geo.naturalEarth()
            .scale(map.width / 5)
            # hide most of Antarctica and move a little to the left
            .translate([(map.width / 2.2), (map.height / 1.7)])
            .precision(.1)

        map.path = d3.geo.path()
            .projection(projection);

        map.svg = d3.select(selector).append('svg')
            .attr('width', map.width)
            .attr('height', map.height)

        svg_countries = map.svg.append('g')
            .attr('class', 'countries')
            .selectAll('path')
            .data(topojson.feature(geo, geo.objects.subunits).features)

        svg_countries.enter().append('path')
            .attr('class', 'country')
            .style('fill', (d)-> map.color d)
            .attr('d', map.path)
            .append('title')
                .text((d)-> d.properties.name)

        mesh = topojson.mesh(geo, geo.objects.subunits, (a, b)-> a != b)
        map.svg.insert('path')
            .datum(mesh)
            .attr('class', 'boundary')
            .attr('d', map.path)


init = (error, geo) ->
    console.log geo
    map.draw '#map', geo


queue()
    .defer(d3.json, 'geo/countries.topo.json')
    .await(init)