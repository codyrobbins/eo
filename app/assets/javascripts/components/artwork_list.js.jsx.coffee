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
    `<div>
  <LoadingIndicator content={this.artworks()} />
  <div className="container-fluid">
    <div className="row">
      {this.items()}
    </div>
  </div>
</div>
`

  artworks: ->
    @state.artworks

  items: ->
    @artworks().map (artwork) =>
      @itemComponent(artwork)

  itemComponent: (artwork) ->
    `<ArtworkListItem artwork={artwork} key={artwork.id} />`