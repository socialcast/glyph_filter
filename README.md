# glyph_filter_

Easily filter content by a list of characters

## Usage

app/controllers/users_controller.rb
```ruby
class UserController < ActionController::Base
  def index
    @users=User.letter_filter(:name, params[:letter])
  end
end
```

app/views/users/index.html.haml
```haml
= glyph_filter
= render :partial => @users
```

## Features

* No active record model class methods.  Just call the scope.
* Works with haml and erb
* Easily create a different layout by simply overriding the view partials

## Installation

```ruby
# Bundler Gemfile
gem 'glyph_filter_'
```

## Configuration

```ruby
# config/initializers/glyph_filter.rb
GlyphFilter.configure do |config|
# (optional) customize letters to filter by
# default is ("A".."Z").to_a
  config.letters = ("b".."y").to_a

# (optional) customize param_name to use a different query param
# default is :letter
  config.param_name = :glyph

# (optional) customize the string used to distinguish the 'left_over' content
# default is "?"
  config.left_over = "!"

# (optional) customize the string used to show all content
# default is "ALL"
  config.all = "MOST"
end
```

## Contributing
 
* Fork the project
* Fix the issue
* Add unit tests
* Submit pull request on github

## Copyright

Copyright (c) 2011 Socialcast, Inc. 
See LICENSE.txt for further details.
