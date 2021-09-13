require_relative "./whale_wisdom.rb"
require "json"

def run(args)
  ww = WhaleWisdom.new(
    secret_key: ENV["WW_SECRET_KEY"], 
    shared_key: ENV["WW_SHARED_KEY"])
  ww.request(args.to_json)
end

puts run({command: "quarters"})
