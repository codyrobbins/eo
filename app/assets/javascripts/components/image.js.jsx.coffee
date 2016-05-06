class @Image extends React.Component
  render: ->
    `<img src={this.url()} width={this.width()} height={this.height()} alt={this.props.alt} />`

  url: ->
    @first_image().url

  width: ->
    @first_image().width

  height: ->
    @first_image().height

  first_image: ->
    @props.images[0]