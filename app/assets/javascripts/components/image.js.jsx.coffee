class @Image extends React.Component
  render: ->
    `<img src={this.url()} width={this.width()} height={this.height()} alt={this.props.alt} />`

  url: ->
    @image().url

  width: ->
    @image().width

  height: ->
    @image().height

  image: ->
    @props.images[@props.index]