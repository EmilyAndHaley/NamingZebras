$(document).ready(function() {
  var numbers, countries;

/*// instantiate the bloodhound suggestion engine
var numbers = new Bloodhound({
datumTokenizer: function(d) { return Bloodhound.tokenizers.whitespace(d.num); },
queryTokenizer: Bloodhound.tokenizers.whitespace,
local: [
{ num: 'one' },
{ num: 'two' },
{ num: 'three' },
{ num: 'four' },
{ num: 'five' },
{ num: 'six' },
{ num: 'seven' },
{ num: 'eight' },
{ num: 'nine' },
{ num: 'ten' }
]
});
 
// initialize the bloodhound suggestion engine
numbers.initialize();
 
// instantiate the typeahead UI
$('.example-numbers .typeahead').typeahead(null, {
displayKey: 'num',
source: numbers.ttAdapter()
});
*/

  var countries = new Bloodhound({
    datumTokenizer: function(d) { return Bloodhound.tokenizers.whitespace(d.name); },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    limit: 10,
    prefetch: {
    url: 'http://localhost:3000/suggestions',
      filter: function(list) {
        nameArray = [];
        for( var i = 0; i < list.length; ++i){
          nameArray.push(list[i].name);
        }
        window.alert(nameArray)
        return nameArray;
      }
    }
  });
 
  countries.initialize();
 
  $('.example-countries .typeahead').typeahead(null, {
    name: 'symptoms',
    source: countries.ttAdapter()
  });

});