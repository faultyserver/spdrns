require "yaml"

require "./lib/view.cr"
require "./lib/views/*"

YAML.parse(File.read("config/pages.yml")).each do |page|
  template = View.view_for(page["template"])
  foo = template.new(page)
  File.write(page["output"].to_s, foo.to_s)
end
