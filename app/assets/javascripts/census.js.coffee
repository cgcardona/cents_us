# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Copyright 2012, Carlos Cardona v0.1.1
# Released under the MIT License.
# http://www.opensource.org/licenses/mit-license.php
#
#      ___           ___           ___                         ___                    ___           ___     
#     /\__\         /\__\         /\  \                       /\__\                  /\  \         /\__\    
#    /:/  /        /:/ _/_        \:\  \         ___         /:/ _/_                 \:\  \       /:/ _/_   
#   /:/  /        /:/ /\__\        \:\  \       /\__\       /:/ /\  \                 \:\  \     /:/ /\  \  
#  /:/  /  ___   /:/ /:/ _/_   _____\:\  \     /:/  /      /:/ /::\  \            ___  \:\  \   /:/ /::\  \ 
# /:/__/  /\__\ /:/_/:/ /\__\ /::::::::\__\   /:/__/      /:/_/:/\:\__\          /\  \  \:\__\ /:/_/:/\:\__\
# \:\  \ /:/  / \:\/:/ /:/  / \:\~~\~~\/__/  /::\  \      \:\/:/ /:/  /          \:\  \ /:/  / \:\/:/ /:/  /
#  \:\  /:/  /   \::/_/:/  /   \:\  \       /:/\:\  \      \::/ /:/  /            \:\  /:/  /   \::/ /:/  / 
#   \:\/:/  /     \:\/:/  /     \:\  \      \/__\:\  \      \/_/:/  /              \:\/:/  /     \/_/:/  /  
#    \::/  /       \::/  /       \:\__\          \:\__\       /:/  /                \::/  /        /:/  /   
#     \/__/         \/__/         \/__/           \/__/       \/__/                  \/__/         \/__/    
# ASCII art by http://patorjk.com/software/taag/

class Census
  constructor : (@authKey) ->
      
  # We're querying the American Community Survey 5 Year DataSet
  # The following variables were found http://www.census.gov/developers/data/acs_5yr_2011_var.xml
  queryCensus : ->
    @searchFilters = [
      'B02001_001E',  # 0. total race
      'B02001_002E',  # 1. total caucasian american
      'B02001_003E',  # 2. total african american
      'B02001_004E',  # 3. total native american
      'B02001_005E',  # 4. total asian american
      'B02001_006E',  # 5. total native hawaiian
      'B17020A_001E', # 6. total caucasian american under poverty
      'B17020A_003E', # 7. caucasian american under 5
      'B17020A_004E', # 8. caucasian american 5
      'B17020A_005E', # 9. caucasian american 6 to 11
      'B17020A_006E', # 10. caucasian american 12 to 17
      'B17020A_007E', # 11. caucasian american 18 to 64
      'B17020A_008E', # 12. caucasian american 65 to 74
      'B17020A_009E', # 13. caucasian american 75 and above
      'B17020B_001E', # 14. total african american under poverty 
      'B17020B_003E', # 15. african american under 5
      'B17020B_004E', # 16. african american 5
      'B17020B_005E', # 17. african american 6 to 11
      'B17020B_006E', # 18. african american 12 to 17
      'B17020B_007E', # 19. african american 18 to 64
      'B17020B_008E', # 20. african american 65 to 74
      'B17020B_009E', # 21. african american 75 and above
      'B17020C_001E', # 22. total native american under poverty 
      'B17020C_003E', # 23. native american under 5
      'B17020C_004E', # 24. native american 5
      'B17020C_005E', # 25. native american 6 to 11
      'B17020C_006E', # 26. native american 12 to 17
      'B17020C_007E', # 27. native american 18 to 64
      'B17020C_008E', # 28. native american 65 to 74
      'B17020C_009E', # 29. native american 75 and above
      'B17020D_001E', # 30. total asian american under poverty 
      'B17020D_003E', # 31. asian american under 5
      'B17020D_004E', # 32. asian american 5
      'B17020D_005E', # 33. asian american 6 to 11
      'B17020D_006E', # 34. asian american 12 to 17
      'B17020D_007E', # 35. asian american 18 to 64
      'B17020D_008E', # 36. asian american 65 to 74
      'B17020D_009E', # 37. asian american 75 and above
      'B17020E_001E', # 38. total hawaiian american under poverty 
      'B17020E_003E', # 39. hawaiian american under 5
      'B17020E_004E', # 40. hawaiian american 5
      'B17020E_005E', # 41. hawaiian american 6 to 11
      'B17020E_006E', # 42. hawaiian american 12 to 17
      'B17020E_007E', # 43. hawaiian american 18 to 64
      'B17020E_008E', # 44. hawaiian american 65 to 74
      'B17020E_009E'  # 45. hawaiian american 75 and above
    ]

    # Concatenate all the search filter variables into a string for the GET request
    urlStr = ''
    _.each(@searchFilters, (element, index, list) ->
      urlStr += element + ','
    )

    #console.log urlStr
    # Use $.ajax instead of $.get so that we can bound the context of this *yeah* 
    # Also use our super secret authKey that we've stashed in another file *oh yeah*
    $.ajax
      context : this
      type : 'get'
      url : 'http://api.census.gov/data/2010/acs5?key=' + @authKey + '&get=' + urlStr + 'NAME&for=state:*'
      success : @queryCensusSuccess

  queryCensusSuccess : (data) ->
    #console.log data

    # Ok the query to the api was a success PHEW
    tmpArr = [
      ['totalPopulation', 'Total'],
      ['caucasionAmericanPopulation', 'Caucasian'],
      ['africanAmericanPopulation', 'African'],
      ['nativeAmericanPopulation', 'Native'],
      ['asianAmericanPopulation', 'Asian'],
      ['hawaiianAmericanPopulation', 'Hawaiian']
    ]

    # Now lets create a nested Object with the [0]th index of tmpArr as
    # the Object's properties and each property getting a copy of the below object
    @populationTotals = {}
    _.each(tmpArr, (element, index, list) ->
      @populationTotals[element[0]] =
        total               : 0
        totalBelow          : 0
        percentage          : 0
        below5              : 0
        at5                 : 0
        sixTo11             : 0
        twelveTo17          : 0
        eighteenTo64        : 0
        sixtyFiveTo74       : 0
        seventyFiveAndAbove : 0
        type                : element[1]
    , this)

    @populationTypes = [
      'totalPopulation',
      'caucasionAmericanPopulation',
      'africanAmericanPopulation',
      'nativeAmericanPopulation',
      'asianAmericanPopulation',
      'hawaiianAmericanPopulation',
    ]

    indexMap = [
      [6,7,8,9,10,11,12,13],
      [14,15,16,17,18,19,20,21],
      [22,23,24,25,26,27,28,29],
      [30,31,32,33,34,35,36,37],
      [38,39,40,41,42,43,44,45]
    ]
    _.each(data, (element, index, list) ->
      if index isnt 0
        #console.log element
        _.each(@populationTypes, (elt, ind, ls) ->
          @populationTotals[elt].total                 += parseInt(element[ind], 10)
          if ind isnt 0
            @populationTotals[elt].totalBelow          += parseInt(element[indexMap[ind - 1][0]], 10)
            @populationTotals[elt].below5              += parseInt(element[indexMap[ind - 1][1]], 10)
            @populationTotals[elt].at5                 += parseInt(element[indexMap[ind - 1][2]], 10)
            @populationTotals[elt].sixTo11             += parseInt(element[indexMap[ind - 1][3]], 10)
            @populationTotals[elt].twelveTo17          += parseInt(element[indexMap[ind - 1][4]], 10)
            @populationTotals[elt].eighteenTo64        += parseInt(element[indexMap[ind - 1][5]], 10)
            @populationTotals[elt].sixtyFiveTo74       += parseInt(element[indexMap[ind - 1][6]], 10)
            @populationTotals[elt].seventyFiveAndAbove += parseInt(element[indexMap[ind - 1][7]], 10)
        ,this)
    ,this)

    _.each(@populationTotals, (element, index, list) ->
      element.percentage = element.total / @populationTotals.totalPopulation.total * 100
    ,this)

    @paintPixels()

  paintPixels : ->
    tmpUl = $('<ul></ul>')
    _.each(@.populationTotals, (element, index, list) ->
      if index is 'totalPopulation'
        $(tmpUl).append($('<li></li>').text('Total Population: ' + element.total))
      else 
        $(tmpUl).append($('<li></li>').text(element.type + ' total population: ' + element.total + ', percentage: ' + element.percentage.toFixed(2)))

      if element.type isnt 'Total'
        innerUl = $('<ul></ul>')
        $(innerUl).append($('<li></li>').text(element.type))
        $(innerUl).append($('<li></li>').text('Total below poverty: ' + parseInt(element.totalBelow, 10)))
        $(innerUl).append($('<li></li>').text('Below 5: ' + parseInt(element.below5, 10)))
        $(innerUl).append($('<li></li>').text('At 5: ' + parseInt(element.at5, 10)))
        $(innerUl).append($('<li></li>').text('6 to 11: ' + parseInt(element.sixTo11, 10)))
        $(innerUl).append($('<li></li>').text('12 to 17: ' + parseInt(element.twelveTo17, 10)))
        $(innerUl).append($('<li></li>').text('18 to 64: ' + parseInt(element.eighteenTo64, 10)))
        $(innerUl).append($('<li></li>').text('65 to 74: ' + parseInt(element.sixtyFiveTo74, 10)))
        $(innerUl).append($('<li></li>').text('75 and above: ' + parseInt(element.seventyFiveAndAbove, 10)))
        $('#bottomOutputContainer').append(innerUl)
    , this)

    $('#topOutputContainer').html('')
    $('#topOutputContainer').append($('<h2>United States</h2>'))
    $('#topOutputContainer').append(tmpUl)
  
$(document).ready ->
  cents_us = new Census($('#authKey').attr('data-authKey'))
  cents_us.queryCensus()
