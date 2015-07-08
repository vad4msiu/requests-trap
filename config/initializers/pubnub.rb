publish_key   = ENV['PUBNUB_PUBLISH_KEY'] || 'demo'
subscribe_key = ENV['PUBNUB_SUBSCRIBE_KEY'] || 'demo'

$pubnub = Pubnub.new(
  publish_key:      publish_key,
  subscribe_key:    subscribe_key,
  error_callback:   ->(msg) { puts "ERROR:     #{msg.inspect}" },
  connect_callback: ->(msg) { puts "CONNECTED: #{msg.inspect}" }
)