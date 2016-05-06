class @ArtworkListItem extends React.Component
  constructor: (props) ->
    super(props)
    @setInitialState()

  setInitialState: ->
    @state = {disclosed: false}

  render: ->
    `<div className="col-xs-12 col-sm-6 col-md-4 text-center artwork-list-item">
  <a href="#" onClick={this.open}>
    <img src={this.thumbnail_url()} alt={'A thumbnail of ‘' + this.artwork().title + '’'} />
    <h3>{this.artwork().title}</h3>
    <p>By {this.artwork().artist_name}</p>
  </a>
  {this.detailsIfDisclosed()}
</div>
`

  open: (event) =>
    @updateDisclosure(event, true)

  close: (event) =>
    console.log('here')
    @updateDisclosure(event, false)

  updateDisclosure: (event, disclosed) ->
    event.preventDefault()
    @setState(disclosed: disclosed)

  thumbnail_url: ->
    @first_thumbnail().url

  first_thumbnail: ->
    @thumbnails()[0]

  thumbnails: ->
    @animated_thumbnails().concat(@static_thumbnails())

  animated_thumbnails: ->
    @artwork().animated_previews

  static_thumbnails: ->
    @artwork().static_previews

  artwork: ->
    @props.artwork

  detailsIfDisclosed: ->
    @details() if @disclosed()

  disclosed: ->
    @state.disclosed

  details: ->
    `<ArtworkDetails artwork={this.artwork()} closeHandler={this.close} />`