# Require From Here

<code>require</code> from here and now.

## Tired
Tired of adjusting ruby loading paths? Tired of making modules auto-loaders? Tired of writting namespace/class-name to path mappings?

If the answer is "yes", maybe require\_from\_here will seem nice to you.

## Just require

    $ find lib/solution/
    lib/solution/file0.rb
    lib/solution/file1.rb
    lib/solution/submodule/file2.rb
    ...

Three ways. Choose the last.

### Masochist way

    $ vim lib/solution.rb
    module Solution
      RequireFromHere.install_on {}
      require_from_here 'file0'
      require_from_here 'file1'
      # no issue
    end

### Typist way

    $ vim lib/solution.rb
    module Solution
      RequireFromHere.require_from_here { 'file0' }
      RequireFromHere.require_from_here { [ 'submodule', 'file2'] }
    end

### Rubyist way!

    $ vim lib/solution.rb
    RequireFromHere.from_here do
      require 'file0'
      require 'file1'
      require 'submodule/file2'
    end

## Installation

    $ vim Gemfile
```ruby
gem 'require_from_here', github: 'mouchtaris/require_from_here'
```
