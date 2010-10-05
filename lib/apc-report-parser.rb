#!/usr/bin/env ruby
require 'rubygems'
require 'uri'
require 'net/http'
require 'nokogiri'

class ReportNotInitializedError < StandardError
end

# The loader and parser should be factored out, but this is good enough for now
class APCStatsReport

  def initialize(uri="http://localhost:80/apc.php", lazy_load=true)
    @uri = URI.parse(uri)
    @lazy_load = lazy_load
  end

  def retrieve_report!
    resource = Net::HTTP.start(@uri.host, @uri.port) do |http|
      http.get(@uri.path)
    end
    @report = parse_resource_into_report(resource)
  end

  def report
    if @report.nil?
      raise ReportNotInitializedError unless @lazy_load
      retrieve_report!
    end
    @report
  end

  private

  def parse_resource_into_report(resource)
    document = Nokogiri::HTML(resource.body)
    headers = extract_headers(document)
    report = headers.inject(Hash.new) do |results, header|
      results[header.text] = extract_substats(header)
      results
    end
    report["Memory Utilization"] = extract_memory_utilization(document)
    return report
  end

  def extract_headers(document)
    document.css('body div.content div.info h2')
  end

  def extract_substats(header)
    header.parent.children.css('tr').inject(Hash.new) do |substats, row|
      label = row.children[0]
      data = row.children[1]
      substats[label.text] = data.text
      substats
    end
  end

  def extract_memory_utilization(document)
    output = {}
    return output
  end
end
