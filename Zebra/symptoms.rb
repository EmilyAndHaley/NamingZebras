require 'nokogiri'

sympFile = File.open("Test.xml")
@doc = Nokogiri::XML(sympFile)
sympFile.close

@doc.xpath("//Disorder").each do |x|
	orphanumber = x.at('OrphaNumber').text
	puts "Orphanumber: #{orphanumber}"
end