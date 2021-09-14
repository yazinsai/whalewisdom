# WhaleWisdom API

A class that allows you to easily query the WhaleWisdom API in Ruby. Their "[API Docs](https://whalewisdom.com/shell/api_help)" are a load of crap. Forget formatting or logs, they don't even have working examples..

## Setup

1. Setup the following environment variables: `WW_SECRET_KEY`, `WW_SHARED_KEY`. You'll find these in the [WhaleWisdom Dashboard](https://whalewisdom.com/dashboard2/user)

2. Run your commands. We've included an example in `main.rb`:


```ruby
require_relative "./whale_wisdom.rb"
require "json"

def run(args)
  ww = WhaleWisdom.new(
    secret_key: ENV["WW_SECRET_KEY"], 
    shared_key: ENV["WW_SHARED_KEY"])
  ww.request(args.to_json)
end

# Get all the quarters
puts run({command: "quarters"})

# Get the holdings for a given filer
puts run({
  command: "holdings",
  filer_ids: [101215],
  include_13d: 1
})
```
