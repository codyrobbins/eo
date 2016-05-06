class @ArtworkListItem extends React.Component
  constructor: (props) ->
    super(props)
    @setInitialState()

  setInitialState: ->
    @state = @initialState

  initialState: {disclosed: false}

  render: ->
    `<div className="artwork-list-item col-xs-12 col-sm-6">
  <div className="container">
    <a href="#" onClick={this.open}>
      <ArtworkHeader artwork={this.artwork()} />
      <div className="image-container">
        <Image images={this.previews()} alt={'A preview of ‘' + this.artwork().title + '’'} index="3" />
      </div>
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
    `<ArtworkDetails artwork={this.artwork()} closeHandler={this.close} key={this.artwork().id} />`