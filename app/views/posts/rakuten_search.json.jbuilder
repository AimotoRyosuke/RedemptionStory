json.array! @items do |item|
  json.name item.name
  json.caption item.caption
  json.images item.medium_image_urls
  json.url item.affiliate_url
  json.keyword @keyword
end