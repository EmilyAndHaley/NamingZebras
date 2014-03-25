$(document).ready(function() {
  var symptoms;

  var symptoms = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    limit: 10,
    prefetch: {
      // url points to a json file that contains an array of symptom names, see
      url: '/suggestions.json',
      // the json file contains an array of strings, but the Bloodhound
      // suggestion engine expects JavaScript objects so this converts all of
      // those strings
      filter: function(list) {
        return $.map(list, function(symptom) { return { name: symptom }; });
      }
    }
  });
   
  // kicks off the loading/processing of `local` and `prefetch`
  symptoms.initialize();
   
  // passing in `null` for the `options` arguments will result in the default
  // options being used
  $('#prefetch .typeahead').typeahead(null, {
    name: 'symptoms',
    displayKey: 'name',
    // `ttAdapter` wraps the suggestion engine in an adapter that
    // is compatible with the typeahead jQuery plugin
    source: symptoms.ttAdapter()
  });

});