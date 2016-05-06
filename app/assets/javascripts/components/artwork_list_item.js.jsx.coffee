class @ArtworkListItem extends React.Component
  constructor: (props) ->
    super(props)
    @setInitialState()

  setInitialState: ->
    @state = @initialState

  initialState: {disclosed: false}

  render: ->
    `<div className="col-xs-12 col-sm-6 col-md-4 artwork-list-item">
  <div className="text-center">
    <a href="#" onClick={this.open}>
      <Image images={this.previews()} alt={'A preview of ‘' + this.artwork().title + '’'} />
      <h3>{this.artwork().title}</h3>
      <p>By {this.artwork().artist_name}</p>
    </a>
  </div>
  {this.detailsIfDisclosed()}
</div>
`

  open: (event) =>
    @changeDisclosure(event, true)

  close: (event) =>
    @changeDisclosure(event, false)

  changeDisclosure: (event, disclosed) ->
    event.preventDefault()
    @setDisclosed(disclosed)

  setDisclosed: (disclosed) ->
    @setState(disclosed: disclosed)

  previews: ->
    @animated_previews().concat(@static_previews())

  animated_previews: ->
    @artwork().animated_previews

  static_previews: ->
    @artwork().static_previews

  artwork: ->
    @props.artwork

  detailsIfDisclosed: ->
    @details() if @state.disclosed

  details: ->
    `<ArtworkDetails artwork={this.artwork()} closeHandler={this.close} />`