load 'facebook_client.rb'
access_token = "TOKEN"
client = Facebook::Client.new(access_token: access_token)
posts = client.get_posts
for post in posts
  puts "#{post['created_time']}: #{post['message']}"
end
client = Facebook::Client.default
puts client.get_user_information
posts = client.get_posts(keyword: 'message')
pp posts
post = posts.last
comments = client.get_comments(post_id: post['id'])
pp comments
client.display_feed