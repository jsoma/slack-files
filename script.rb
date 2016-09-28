require 'slack-ruby-client'
require 'pry'

client = Slack::Web::Client.new(token: ENV['slack-token'])
client.auth_test

total_files = (1..5).inject([]) { |memo, num|
  memo.push(*client.files_list(page: num).files)
}

total_files.sort_by{ |r| r['size'] }.each do |file|
  puts "%20s %10s %-40s %10s" % [ file['size'], file.channels.first, file.name, file.user]
end
