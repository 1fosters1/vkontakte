require 'bundler'
Bundler.setup :default

require 'pry'
require 'vkontakte'

puts Vkontakte::VERSION

if __FILE__ == $0
  CLIENT_ID = '5987497'

  email = ARGV[0]
  pass  = ARGV[1]

  vk = Vkontakte::Client.new(CLIENT_ID)
  vk.login!(email, pass, permissions: 'friends,wall')

  current_user = vk.api.users_get.first

  friend_ids = vk.api.friends_get['items']
  puts "Запрещает показывать новости от всех друзей"
  friend_ids.each_slice(100) do |user_ids|
    vk.api.newsfeed_addBan(user_ids: user_ids.join(","))
  end
  puts vk.api.newsfeed_getBanned
end