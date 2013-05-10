# Nesta::Plugin::Automenu

With the help of this plugin for the NestaCMS it is possible to include a menu
containing links to all files in content.
Or it is possible to restrict the file discovery to a specific pattern.

## Installation

Add this line to your application's Gemfile:

    gem 'nesta-plugin-automenu'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nesta-plugin-automenu

## Usage

Include in your theme the appropriate helper methods:

* AutoMenu.menu( options = {} )

* Options:

* For the complete menu
** :list\_class     => "menu"
** :list\_id        => "menu"
** :list\_tag       => "ul"

* For the single element of the menu
** :element\_class  => "menu.element"
** :element\_id     => ""
** :element\_tag    => "li"

* For the reference element, where you click on :)
** :link\_class     => "menu.element.link"
** :link\_id        => ""
** :link\_tag       => "a"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
