class @ArtworkHeader extends React.Component
  render: ->
    `<div className="header text-left">
  <h3>{this.props.artwork.title}</h3>
  <p>By {this.props.artwork.artist_name}</p>
</div>
`
