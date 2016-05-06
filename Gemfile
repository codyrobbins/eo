source('https://rubygems.org')
ruby('2.3.1')

# Rails.
gem('rails', '~> 4.2.6')

# Markup, styling, and scripting.
gem('haml-rails',     '~> 0.9.0')
gem('sass-rails',     '~> 5.0.4')
gem('bootstrap-sass', '~> 3.3.6')
gem('uglifier',       '~> 2.7.2')
gem('react-rails',    '~> 1.7.0')
gem('coffee-rails',   '~> 4.1.1')
gem('jquery-rails',   '~> 4.1.1')
gem('rails-timeago',  '~> 2.13.0')

# Server.
gem('thin')

group(:development, :test) do
  # Database.
  gem('sqlite3')

  # Debugging.
  gem('pry-rails')
  gem('byebug')
end

group(:development) do
  # Debugging.
  gem('better_errors')
  gem('binding_of_caller')
end

group(:production) do
  # Database.
  gem('pg', '~> 0.18.4')

  # Heroku,
  gem('rails_12factor', '~> 0.0.3')
end