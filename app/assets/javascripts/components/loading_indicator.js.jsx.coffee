class @LoadingIndicator extends React.Component
  render: ->
    `<div>{this.indicator()}</div>`

  indicator: ->
    'Loading' if @loading()

  loading: ->
    Utility.isEmpty(@props.content)