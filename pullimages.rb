require 'open-uri'

def download_image(url, destination)
  URI.open(url) do |path|
    File.open(destination, 'wb') { |f| f.write(path.read)}
  end
end

898.times do |count|
  download_image("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/#{count + 1}.png",
               "app/assets/images/pokemon-sprites/#{count + 1}.png")
  p "Downloaded PNG #{count + 1}/898"
end
