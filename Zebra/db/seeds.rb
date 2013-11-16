require 'nokogiri'

sympFile = File.open("Dataset.xml")
@doc = Nokogiri::XML(sympFile)
sympFile.close()
symptomsList = []

@doc.xpath("//DisorderSign").each do |x|
	signId = x.at('ClinicalSign').attribute('id').text()
	name = x.at('ClinicalSign').element_children().text()
	Symptom.where(:name => name, :signId => Integer(signId)).first_or_create
end