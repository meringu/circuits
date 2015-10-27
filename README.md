[![Build Status](https://travis-ci.org/meringu/circuits.svg?branch=master)](https://travis-ci.org/meringu/circuits)
[![Gem Version](https://badge.fury.io/rb/circuits.svg)](https://badge.fury.io/rb/circuits)
[![Coverage Status](https://coveralls.io/repos/meringu/circuits/badge.svg?branch=master&service=github)](https://coveralls.io/github/meringu/circuits?branch=master)
[![Code Climate](https://codeclimate.com/github/meringu/circuits/badges/gpa.svg)](https://codeclimate.com/github/meringu/circuits)
[![Dependency Status](https://gemnasium.com/meringu/circuits.svg)](https://gemnasium.com/meringu/circuits)
[![docs](http://inch-ci.org/github/meringu/circuits.svg?branch=master)](http://inch-ci.org/github/meringu/circuits)

# Circuits

Express logical circuits in code!

## How it works

You define components in terms of other component's inputs and outputs. Every
"tick" the components compute their next outputs. In between each "tick" the
"tock" will update the outputs before the next tick

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'circuits'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install circuits

## Usage

### Using a component

```ruby
and_gate = Circuits::Component::And.new
# Set the inputs
and_gate[:a].set true
and_gate[:b].set false
# Update the AND gate
and_gate.tick # compute the next output from the inputs
and_gate.tock # apply to the output after all components have "ticked"
# Get the output
and_gate[:out].get # false
```

### Linking components

```ruby
and_gate = Circuits::Component::And.new
not_gate = Circuits::Component::Not.new
not_gate[:in].set = and_gate[:out]
```

## Contributing

1. Fork it ( https://github.com/meringu/circuits/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Make your changes
4. Run the tests (`bundle exec rake`)
5. Bump the version ( http://semver.org/ )
6. Push to the branch (`git push origin my-new-feature`)
7. Create a new Pull Request
