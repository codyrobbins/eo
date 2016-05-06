class @ArtworkList extends React.Component
  constructor: (props) ->
    super(props)
    @setInitialState()

  setInitialState: ->
    @state = @initialState

  initialState: {artworks: []}

  componentDidMount: ->
    API.load('', @didLoadArtworks)

  didLoadArtworks: (artworks) =>
    @setState(artworks: artworks)

  render: ->
    `<div>{this.items()}</div>`

  items: ->
    @state.artworks.map (artwork) =>
      @itemComponent(artwork)

  itemComponent: (artwork) ->
    `<ArtworkListItem artwork={artwork} />`