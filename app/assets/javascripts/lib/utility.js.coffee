class @Utility
  @isEmpty: (array) ->
    !@isNotEmpty(array)

  @isNotEmpty: (array) ->
    array?.length > 0