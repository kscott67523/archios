# AppdevSupport

This gem adds patches that are used to make Ruby and Ruby on Rails environments more beginner friendly.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "appdev_support", github: "firstdraft/appdev_support"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install appdev_support

Run

```rb
AppdevSupport.init
```
to load the default settings.

Create an [initializer](#configuration) file for customization.

## Usage

Once installed, you can do things like:

```ruby
# in app/controllers/events_controller.rb
class EventsController < ApplicationController 
  def index
    cookies.store(:theme, "dark")
    cookies.fetch(:theme)
    session.fetch(:user_id)
  end
end
```

and `session.fetch` will raise a `KeyNotFound` Exception.

`.fetch` can be called on `session`, `cookies`, and any `ActiveRecord` object. For an `ActiveRecord` object, you can `.fetch` a column.

```ruby
Event.fetch(:starts_on) # => "Mon, 23 Mar 2020 23:25:48"
```

Similarly, `.store` can be called on `session` and `cookies` with the expected behavior. 

```ruby
session.store(:user_id, 1)
```

Displaying an `ActiveRecord::Relation` in a View file will display:

```rb
Event::ActiveRecord_Relation (array with 4 Event instances inside)
```

You can call `.at` on an `ActiveRecord::Relation` instead of just `[]` to mirror how Arrays work.

```ruby
Event.all.at(0)
```

If the containing app has `pry` or `pry-rails` installed, the `print` functionality has been enhanced:
With the value `:mimimal`:
- `ActiveRecord::Relation` objects are displayed like this:
  ```irb
  pry(main)> Todo.all
  => Todo::ActiveRecord_Relation (array with 1 Todo instance inside)
  ```
With the value `:debug`
- `ActiveRecord::Relation` objects are displayed like this:
  ```irb
  pry(main)> Todo.all
  Todo Count (0.3ms)  SELECT COUNT(*) FROM "todos"
  Todo Load (0.2ms)  SELECT "todos".* FROM "todos"
  +----+-------+------+---------------------------------------------+
  | id | title | body | {:header_frequency=>10, :border=>:markdown} |
  +----+-------+------+---------------------------------------------+
  |  1 | test  | nope |                                             |
  +----+-------+------+---------------------------------------------+

    Todo Count (0.3ms)  SELECT COUNT(*) FROM "todos"
  => Todo::ActiveRecord_Relation (array with 1 Todo instance inside)
  ```
- `Class` objects are displayed like this:
  ```irb
  pry(main)> Todo
  => Todo(id: integer, title: string, body: text, created_at: datetime, updated_at: datetime)

  The Todo class itself.
  ```
- All other objects are displayed like this:
  ```irb
  pry(main)> "hello, world"
  => "hello, world"

  An instance of the String class.
  ```

## Configuration

Add an initializer:

```rb
AppdevSupport.config do |config|
# config.action_dispatch = true
# config.active_record   = true
# config.pryrc           = :minimal
end
AppdevSupport.init
```

In a Rails app, this usually means creating a file in the `config/` folder called `appdev_support.rb`

By default, these settings are `true`. Turn any of them off here. Options are currently grouped by highest parent class.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/firstdraft/appdev_support. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/firstdraft/appdev_support/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AppdevSupport project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/firstdraft/appdev_support/blob/master/CODE_OF_CONDUCT.md).
