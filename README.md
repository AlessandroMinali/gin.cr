# gin.cr

[Rum](https://github.com/chneukirchen/rum) minified and crystalized.

Inspiration [from](https://github.com/tbrand/router.cr) as well.

## Installation

Add this to your application"s `shard.yml`:

```yaml
dependencies:
  gin:
    github: AlessandroMinali/gin
```

## Usage

### Basic usage
```crystal
require "gin"
```

Include `Router` to utilize **router.cr**.
```crystal
class App
  include Gin
end
```

Must implement `def routes` to capture requests
```crystal
class App
  include Gin

  def routes
    # routes here!?
  end
end
```

### HTTP Methods
Supports GET, POST, PUT, DELETE.
```crystal
class App
  include Gin

  def routes
    on get do
      puts "Hello World!"
    end
    on post do
      puts "Goodbye World."
    end
  end
end
```

### Path
```crystal
class App
  include Gin

  def routes
    on get, path("/hello") do
      puts "Hello World!"
    end
    on get, path("/goodbye") do
      puts "Goodbye World."
    end
  end
end
```

### Path Parameters
```crystal
class App
  include Gin

  def routes
    on get, path("/hello"), segement do |_,_,name|
      puts "Hello #{name}"
    end
    on get, path("/goodbye"), segement do |_,_,name|
      puts "Goodbye #{name}."
    end
  end
end
```

### Run Server
```crystal
server = HTTP::Server.new(8080, [App.new])
puts "Listening on http://127.0.0.1:8080"
server.listen
```

## Contributing

1. Fork it ( https://github.com/[your-github-name]/gin/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am "Add some feature")
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [[your-github-name]](https://github.com/[your-github-name]) AlessandroMinali - creator, maintainer
