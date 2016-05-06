class @User extends React.Component
  render: ->
    `<div className="user">
  <div>
    <Image images={this.user().avatar_images} alt={this.user().username + '’s avatar'} index="0" />
  </div>
  <div>
    <h4>{this.user().username}</h4>
    <div>
      <span className="glyphicon glyphicon-user"></span>
      {this.user().followers_count}
    </div>
    <div>
      <span className="glyphicon glyphicon-star"></span>
      {this.user().following_count}
    </div>
  </div>
</div>
`

  user: ->
    @props.user