require 'yaml'
class GetHomepageURL
  ENV['SECTION']
  ENV['brand']
  def load_url()
    brand_url = ''
    begin
      brand_url = YAML.load(File.open("brand_urls.yml"))
    rescue ArgumentError => e
      puts "Could not parse YAML: #{e.message}"
    end
    brand_url
  end

  def get_url(section, brand)
    url_yml = self.load_url
    base_url =  url_yml[section][brand]
    puts base_url
    base_url
  end

end