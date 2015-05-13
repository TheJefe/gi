#!/usr/bin/env ruby

require 'httparty'
require 'haml'

GITHUB_TOKEN=ENV['GITHUB_TOKEN']
GITHUB_USERNAME=ENV['GITHUB_USERNAME']
GITHUB_BASE_URL="https://api.github.com"
QUERY = ENV['GI_QUERY']

def get(uri)
  clean_uri = URI.parse(URI.encode(uri))
  headers = {:headers => {
        'User-Agent' => GITHUB_USERNAME,
        'Authorization' => "token "+GITHUB_TOKEN,
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
      }}
  HTTParty.get(clean_uri, headers)
end

def get_issues()
  uri = "#{GITHUB_BASE_URL}/search/issues?q=#{QUERY}"
  response = get uri
  return unless response['items']
  issues  = response['items']
  label = QUERY.match(/label:\"(.*)\"/)[1]
  puts "GI_QUERY must include a label" unless label
  include_labels(issues, label)
end

def include_labels(issues, label)
  issues.each do |i|
    events = get(i['events_url'])
    label_event = events.select {|e| e['event'] == 'labeled' and e['label']['name'] == label }.last
    label_event['created_at'] = format_time(label_event['created_at'])
    label_data = {'label_data' => label_event }
    i['label_data'] = label_event
  end
end

def format_time(time)
  (Time.parse(time) + Time.zone_offset('EST')).strftime('%Y-%m-%d %I:%M:%S').to_s
end

def html(issues)
  $issues = issues
  file_path = File.expand_path('../template.html.haml', __FILE__)
  template = File.read(file_path)
  engine = Haml::Engine.new(template)
  File.write 'issues.html',engine.render
end

def print(issues)
  issues.each do |issue|
    formatedTime = (Time.parse(issue['label_data']['created_at']) + Time.zone_offset('EST')).strftime('%Y-%m-%d %I:%M:%S').to_s
    output =  issue['html_url'] + " : " + issue['title'] + " : " + formatedTime
    output += ": #{issue['assignee']['login']}" if issue['assignee']
    puts output
  end
end

# MAIN

issues = get_issues
issues = issues.sort_by {|i| i['label_data']['created_at']}
html issues
#print issues
