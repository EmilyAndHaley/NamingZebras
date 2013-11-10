require 'nokogiri'

sympFile = File.open("Test.xml")
@doc = Nokogiri::XML(sympFile)
sympFile.close()

symptoms = []

@doc.xpath("////DisorderSign").each do |x|
	signId = x.at('ClinicalSign').attribute('id').text()
	name = x.at('ClinicalSign').element_children().text()
	symptoms.push([signId, name])
end