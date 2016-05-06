class @ArtworkList extends React.Component
  constructor: (props) ->
    super(props)
    @setInitialState()

  setInitialState: ->
    @state = {artworks: []}

  componentDidMount: ->
    jQuery.getJSON('https://jsonp.afeld.me/?url=http://open-api.electricobjects.com/v4/artworks', @didLoadArtworks)

  didLoadArtworks: (artworks) =>
    @setState(artworks: artworks)

  render: ->
    `<div>{this.items()}</div>`

  items: ->
    @state.artworks.map (artwork) ->
      `<ArtworkListItem artwork={artwork} />`