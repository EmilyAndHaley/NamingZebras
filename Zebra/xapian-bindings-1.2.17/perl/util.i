%{
/* perl/util.i: custom Perl typemaps for xapian-bindings
 *
 * Based on the perl XS wrapper files.
 *
 * Copyright (C) 2009 Kosei Moriyama
 * Copyright (C) 2011 Olly Betts
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
 * USA
 */
%}

/* Rename function next() to increment() since the keyword "next" is already
 * used in Perl. */
%rename(increment) *::next();
%rename(increment_weight) *::next(Xapian::weight min_wt);

/* Wrapping constant values. */
%constant int OP_AND = Xapian::Query::OP_AND;
%constant int OP_OR = Xapian::Query::OP_OR;
%constant int OP_AND_NOT = Xapian::Query::OP_AND_NOT;
%constant int OP_XOR = Xapian::Query::OP_XOR;
%constant int OP_AND_MAYBE = Xapian::Query::OP_AND_MAYBE;
%constant int OP_FILTER = Xapian::Query::OP_FILTER;
%constant int OP_NEAR = Xapian::Query::OP_NEAR;
%constant int OP_PHRASE = Xapian::Query::OP_PHRASE;
%constant int OP_VALUE_RANGE = Xapian::Query::OP_VALUE_RANGE;
%constant int OP_SCALE_WEIGHT = Xapian::Query::OP_SCALE_WEIGHT;
%constant int OP_ELITE_SET = Xapian::Query::OP_ELITE_SET;
%constant int OP_VALUE_RANGE = Xapian::Query::OP_VALUE_RANGE;
%constant int OP_VALUE_GE = Xapian::Query::OP_VALUE_GE;
%constant int OP_VALUE_LE = Xapian::Query::OP_VALUE_LE;
%constant int FLAG_BOOLEAN = Xapian::QueryParser::FLAG_BOOLEAN;
%constant int FLAG_PHRASE = Xapian::QueryParser::FLAG_PHRASE;
%constant int FLAG_LOVEHATE = Xapian::QueryParser::FLAG_LOVEHATE;
%constant int FLAG_BOOLEAN_ANY_CASE = Xapian::QueryParser::FLAG_BOOLEAN_ANY_CASE;
%constant int FLAG_WILDCARD = Xapian::QueryParser::FLAG_WILDCARD;
%constant int FLAG_PURE_NOT = Xapian::QueryParser::FLAG_PURE_NOT;
%constant int FLAG_PARTIAL = Xapian::QueryParser::FLAG_PARTIAL;
%constant int FLAG_SPELLING_CORRECTION = Xapian::QueryParser::FLAG_SPELLING_CORRECTION;
%constant int FLAG_SYNONYM = Xapian::QueryParser::FLAG_SYNONYM;
%constant int FLAG_AUTO_SYNONYMS = Xapian::QueryParser::FLAG_AUTO_SYNONYMS;
%constant int FLAG_AUTO_MULTIWORD_SYNONYMS = Xapian::QueryParser::FLAG_AUTO_MULTIWORD_SYNONYMS;
%constant int FLAG_DEFAULT = Xapian::QueryParser::FLAG_DEFAULT;
%constant int STEM_NONE = Xapian::QueryParser::STEM_NONE;
%constant int STEM_SOME = Xapian::QueryParser::STEM_SOME;
%constant int STEM_ALL = Xapian::QueryParser::STEM_ALL;
%constant int FLAG_SPELLING = Xapian::TermGenerator::FLAG_SPELLING;

/* Xapian::Enquire */
%feature("shadow") Xapian::Enquire::get_mset
%{
sub get_mset {
  my $self = $_[0];
  my $nargs = scalar(@_);
  if( $nargs == 4 ) {
    my $type = ref( $_[2] );
    if ( $type eq 'Search::Xapian::RSet' ) {
      # get_mset(first, max, rset)
      splice @_, 2, 0, (0); # insert checkatleast
    }
  }
  return Search::Xapianc::Enquire_get_mset( @_ );
}
%}

%feature("shadow") Xapian::Enquire::set_query
%{
sub set_query {
  my $self = shift;
  my $query = shift;
  if( ref( $query ) ne 'Search::Xapian::Query' ) {
    $query = Search::Xapian::Query->new( $query, @_ );
    Search::Xapianc::Enquire_set_query( $self, $query );
    return;
  }
  my $nargs = scalar(@_);
  if( $nargs > 1) {
    Carp::carp( "USAGE: \$enquire->set_query(\$query) or \$enquire->set_query(\$query, \$length)" );
    exit;
  }
  Search::Xapianc::Enquire_set_query( $self, $query, @_ );
}
%}

%feature("shadow") Xapian::Enquire::set_sort_by_key
%{
sub set_sort_by_key {
    my $self = $_[0];
    my $sorter = $_[1];
    $self{_sorter} = $sorter;
    Search::Xapianc::Enquire_set_sort_by_key( @_ );
}
%}

%feature("shadow") Xapian::Enquire::set_sort_by_key_then_relevance
%{
sub set_sort_by_key_then_relevance {
    my $self = $_[0];
    my $sorter = $_[1];
    $self{_sorter} = $sorter;
    Search::Xapianc::Enquire_set_sort_by_key_then_relevance( @_ );
}
%}

%feature("shadow") Xapian::Enquire::set_sort_by_relevance_then_key
%{
sub set_sort_by_relevance_then_key {
    my $self = $_[0];
    my $sorter = $_[1];
    $self{_sorter} = $sorter;
    Search::Xapianc::Enquire_set_sort_by_relevance_then_key( @_ );
}
%}

/* Xapian::ESet */
%extend Xapian::ESet {
Xapian::ESetIterator FETCH(int index) {
    return ((*self)[index]);
}
}

/* Xapian::ESetIterator */
%extend Xapian::ESetIterator {
std::string get_termname() {
    return self->operator*();
}

bool equal(Xapian::ESetIterator * that) {
    return ((*self) == (*that));
}

bool nequal(Xapian::ESetIterator * that) {
    return ((*self) != (*that));
}
}

/* Xapian::MSet */
%extend Xapian::MSet {
Xapian::MSetIterator FETCH(int index) {
    return ((*self)[index]);
}
}

/* Xapian::MSetIterator */
%extend Xapian::MSetIterator {
bool equal(Xapian::MSetIterator * that) {
     return ((*self) == (*that));
}

bool nequal(Xapian::MSetIterator * that) {
     return ((*self) != (*that));
}
}

/* Xapian::PositionIterator */
%extend Xapian::PositionIterator {
bool equal1(Xapian::PositionIterator * that) {
     return ((*self) == (*that));
}

bool nequal1(Xapian::PositionIterator * that) {
     return ((*self) != (*that));
}
}

/* Xapian::Query */
%feature("shadow") Xapian::Query::Query
%{
sub new {
  my $class = shift;
  my $query;

  if( @_ == 1 ) {
    $query = Search::Xapianc::new_Query(@_);
  } else {
    my $op = $_[0];
    if( $op !~ /^\d+$/ ) {
	Carp::croak( "USAGE: $class->new('term') or $class->new(OP, <args>)" );
    }
    if( $op == 8 ) { # FIXME: 8 is OP_VALUE_RANGE; eliminate hardcoded literal
      if( @_ != 4 ) {
	Carp::croak( "USAGE: $class->new(OP_VALUE_RANGE, VALNO, START, END)" );
      }
      $query = Search::Xapianc::new_Query( @_ );
    } elsif( $op == 9 ) { # FIXME: OP_SCALE_WEIGHT
      if( @_ != 3 ) {
        Carp::croak( "USAGE: $class->new(OP_SCALE_WEIGHT, QUERY, FACTOR)" );
      }
      $query = Search::Xapianc::new_Query( @_ );
    } elsif( $op == 11 || $op == 12 ) { # FIXME: OP_VALUE_GE, OP_VALUE_LE; eliminate hardcoded literals
      if( @_ != 3 ) {
        Carp::croak( "USAGE: $class->new(OP_VALUE_[GL]E, VALNO, LIMIT)" );
      }
      $query = Search::Xapianc::new_Query( @_ );
    } else {
      shift @_;
      $query = Search::Xapian::newN( $op, \@_ );
    }
  }
  return $query;
}
%}

%typemap(in) SV ** {
	AV *tempav;
	I32 len;
	int i;
	SV  **tv;
	if (!SvROK($input))
	    croak("Argument $argnum is not a reference.");
        if (SvTYPE(SvRV($input)) != SVt_PVAV)
	    croak("Argument $argnum is not an array.");
        tempav = (AV*)SvRV($input);
	len = av_len(tempav);
	$1 = (SV **) malloc((len+2)*sizeof(SV *));
	for (i = 0; i <= len; i++) {
	    tv = av_fetch(tempav, i, 0);
	    $1[i] = *tv;
        }
	$1[i] = NULL;
};

%typemap(freearg) SV ** {
	free($1);
}

%inline %{
Xapian::Query * newN(int op_, SV *q_) {
	Xapian::Query::op op = (Xapian::Query::op)op_;
	AV *q = (AV *) SvRV(q_);
	Xapian::Query * ret;

	try {
	    int items = av_len(q) + 1;
	    vector<Xapian::Query> queries;
	    queries.reserve(items);

	    for( int i = 0; i < items; i++ ) {
		SV **svp = av_fetch(q, i, 0);
		if( svp == NULL )
		    croak("Unexpected NULL returned by av_fetch()");
		SV *sv = *svp;
		if ( sv_isa(sv, "Search::Xapian::Query")) {
		    Xapian::Query *query;
		    SWIG_ConvertPtr(sv, (void **)&query, SWIGTYPE_p_Xapian__Query, 0);
		    queries.push_back(*query);
		} else if ( SvOK(sv) ) {
		    STRLEN len;
		    const char * ptr = SvPV(sv, len);
		    queries.push_back(Xapian::Query(string(ptr, len)));
		} else {
		    croak( "USAGE: Search::Xapian::Query->new(OP, @TERMS_OR_QUERY_OBJECTS)" );
		}
	    }
            ret = new Xapian::Query(op, queries.begin(), queries.end());
        } catch (const Xapian::Error &error) {
            croak( "Exception: %s", error.get_msg().c_str() );
        }
	return ret;
}
%}

/* Xapian::QueryParser */
%feature("shadow") Xapian::QueryParser::QueryParser
%{
sub new {
  my $class = shift;
  my $qp = Search::Xapianc::new_QueryParser();

  bless $qp, $class;
  $qp->set_database(@_) if scalar(@_) == 1;

  return $qp;
}
%}

%feature("shadow") Xapian::QueryParser::set_stopper
%{
sub set_stopper {
    my ($self, $stopper) = @_;
    $self{_stopper} = $stopper;
    Search::Xapianc::QueryParser_set_stopper( @_ );
}
%}

%feature("shadow") Xapian::QueryParser::add_valuerangeprocessor
%{
sub add_valuerangeprocessor {
    my ($self, $vrproc) = @_;
    push @{$self{_vrproc}}, $vrproc;
    Search::Xapianc::QueryParser_add_valuerangeprocessor( @_ );
}
%}

/* Xapian::SimpleStopper */
%feature("shadow") Xapian::SimpleStopper::SimpleStopper
%{
sub new {
    my $class = shift;
    my $stopper = Search::Xapianc::new_SimpleStopper();

    bless $stopper, $class;
    foreach (@_) {
	$stopper->add($_);
    }

    return $stopper;
}
%}

%extend Xapian::SimpleStopper {
bool stop_word(std::string term) {
     return (*self)(term);
}
}

/* Xapian::Stem */
%extend Xapian::Stem {
std::string stem_word(std::string word) {
	    return (*self)(word);
}
}

/* Xapian::TermIterator */
%rename(get_termname) Xapian::TermIterator::get_term;

%extend Xapian::TermIterator {
bool equal(Xapian::TermIterator * that) {
     return ((*self) == (*that));
}

bool nequal(Xapian::TermIterator * that) {
     return ((*self) != (*that));
}
}

/* Xapian::ValueIterator */
%extend Xapian::ValueIterator {
bool equal(Xapian::ValueIterator * that) {
     return ((*self) == (*that));
}

bool nequal(Xapian::ValueIterator * that) {
     return ((*self) != (*that));
}
}

/* Xapian::WritableDatabase */
%rename(replace_document_by_term) \
	Xapian::WritableDatabase::replace_document(const std::string &,
						   const Xapian::Document &);
%rename(delete_document_by_term) \
	Xapian::WritableDatabase::delete_document(const std::string &);

%feature("shadow") Xapian::WritableDatabase::WritableDatabase
%{
sub new {
  my $pkg = shift;
  my $self;
  if( scalar(@_) == 0 ) {
    $self = Search::Xapianc::new3_WritableDatabase(@_);
  } else {
    $self = Search::Xapianc::new_WritableDatabase(@_);
  }
  bless $self, $pkg if defined($self);
}
%}

%inline %{
Xapian::WritableDatabase * new3_WritableDatabase() {
        try {
	    return new Xapian::WritableDatabase(Xapian::InMemory::open());
        }
        catch (const Xapian::Error &error) {
            croak( "Exception: %s", error.get_msg().c_str() );
        }
}
%}

/* Perl code */
%perlcode %{
package Search::Xapian;

our $VERSION = "";

# We need to use the RTLD_GLOBAL flag to dlopen() so that other C++
# modules that link against libxapian.so get the *same* value for all the
# weak symbols (eg, the exception classes)
sub dl_load_flags { 0x01 }

# Items to export into caller's namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration use Search::Xapian ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = (
                    'ops' => [ qw(
                                  OP_AND
                                  OP_OR
                                  OP_AND_NOT
                                  OP_XOR
                                  OP_AND_MAYBE
                                  OP_FILTER
                                  OP_NEAR
                                  OP_PHRASE
				  OP_VALUE_RANGE
				  OP_SCALE_WEIGHT
                                  OP_ELITE_SET
				  OP_VALUE_GE
				  OP_VALUE_LE
                                 ) ],
                    'db' => [ qw(
                                 DB_OPEN
                                 DB_CREATE
                                 DB_CREATE_OR_OPEN
                                 DB_CREATE_OR_OVERWRITE
                                 ) ],
                    'enq_order' => [ qw(
				 ENQ_DESCENDING
				 ENQ_ASCENDING
				 ENQ_DONT_CARE
				   ) ],
                    'qpflags' => [ qw(
				 FLAG_BOOLEAN
				 FLAG_PHRASE
				 FLAG_LOVEHATE
				 FLAG_BOOLEAN_ANY_CASE
				 FLAG_WILDCARD
				 FLAG_PURE_NOT
				 FLAG_PARTIAL
				 FLAG_SPELLING_CORRECTION
				 FLAG_SYNONYM
				 FLAG_AUTO_SYNONYMS
				 FLAG_AUTO_MULTIWORD_SYNONYMS
				 FLAG_DEFAULT
                                 ) ],
                    'qpstem' => [ qw(
				 STEM_NONE
				 STEM_SOME
				 STEM_ALL
                                 ) ]
                   );
$EXPORT_TAGS{standard} = [ @{ $EXPORT_TAGS{'ops'} },
			   @{ $EXPORT_TAGS{'db'} },
			   @{ $EXPORT_TAGS{'qpflags'} },
			   @{ $EXPORT_TAGS{'qpstem'} } ];
$EXPORT_TAGS{all} = [ @{ $EXPORT_TAGS{'standard'} }, @{ $EXPORT_TAGS{'enq_order'} } ];

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

# Preloaded methods go here.

our @OP_NAMES;
foreach (@{ $EXPORT_TAGS{'ops'} }) {
  $OP_NAMES[eval $_] = $_;
}

our @DB_NAMES;
foreach (@{ $EXPORT_TAGS{'db'} }) {
  $DB_NAMES[eval $_] = $_;
}

our @FLAG_NAMES;
foreach (@{ $EXPORT_TAGS{'qpflags'} }) {
  $FLAG_NAMES[eval $_] = $_;
}

our @STEM_NAMES;
foreach (@{ $EXPORT_TAGS{'qpstem'} }) {
  $STEM_NAMES[eval $_] = $_;
}

package Search::Xapian::Database;
sub enquire {
  my $self = shift;
  my $enquire = Search::Xapian::Enquire->new( $self );
  if( @_ ) {
    $enquire->set_query( @_ );
  }
  return $enquire;
}

package Search::Xapian::Enquire;
sub matches {
  my $self = shift;
  return $self->get_mset(@_)->items();
}

package Search::Xapian::ESet;
sub items {
  my $self = shift;
  my @array;
  tie( @array, 'Search::Xapian::ESet', $self );
  return @array;
}

use overload '++' => sub { $_[0]->increment() },
	     '--' => sub { $_[0]->prev() },
             '='  => sub { $_[0]->clone() },
	     'eq' => sub { $_[0]->equal($_[1]) },
	     'ne' => sub { $_[0]->nequal($_[1]) },
	     '==' => sub { $_[0]->equal($_[1]) },
	     '!=' => sub { $_[0]->nequal($_[1]) },
             'fallback' => 1;

sub clone() {
  my $self = shift;
  my $class = ref( $self );
  my $copy = new( $self );
  bless $copy, $class;
  return $copy;
}

sub TIEARRAY {
  my $class = shift;
  my $eset = shift;
  return bless $eset, $class;
}

sub FETCHSIZE {
    my $self = shift;
    return $self->size();
}

package Search::Xapian::ESetIterator;
use overload '++' => sub { $_[0]->increment() },
	     '--' => sub { $_[0]->prev() },
             '='  => sub { $_[0]->clone() },
	     'eq' => sub { $_[0]->equal($_[1]) },
	     'ne' => sub { $_[0]->nequal($_[1]) },
	     '==' => sub { $_[0]->equal($_[1]) },
	     '!=' => sub { $_[0]->nequal($_[1]) },
             'fallback' => 1;

sub clone() {
  my $self = shift;
  my $class = ref( $self );
  my $copy = new( $self );
  bless $copy, $class;
  return $copy;
}

package Search::Xapian::MSet;
sub items {
  my $self = shift;
  my @array;
  tie( @array, 'Search::Xapian::MSet::Tied', $self );
  return @array;
}

sub TIEARRAY {
  my $class = shift;
  my $mset = shift;
  return bless $mset, $class;
}

sub FETCHSIZE {
    my $self = shift;
    return $self->size();
}

package Search::Xapian::MSetIterator;
use overload '++' => sub { $_[0]->increment() },
	     '--' => sub { $_[0]->prev() },
             '='  => sub { $_[0]->clone() },
	     'eq' => sub { $_[0]->equal($_[1]) },
	     'ne' => sub { $_[0]->nequal($_[1]) },
	     '==' => sub { $_[0]->equal($_[1]) },
	     '!=' => sub { $_[0]->nequal($_[1]) },
             'fallback' => 1;

sub clone() {
  my $self = shift;
  my $class = ref( $self );
  bless $self, $class;
  return $self;
}

package Search::Xapian::MSet::Tied;
our @ISA = qw(Search::Xapian::MSet);

package Search::Xapian::PositionIterator;
use overload '++' => sub { $_[0]->increment() },
             '='  => sub { $_[0]->clone() },
	     'eq' => sub { $_[0]->equal($_[1]) },
	     'ne' => sub { $_[0]->nequal($_[1]) },
	     '==' => sub { $_[0]->equal($_[1]) },
	     '!=' => sub { $_[0]->nequal($_[1]) },
             '""' => sub { $_[0]->get_description() },
             '0+' => sub { $_[0]->get_termpos() },
             'fallback' => 1;

sub clone() {
  my $self = shift;
  my $class = ref( $self );
  my $copy = new( $self );
  bless $copy, $class;
  return $copy;
}

sub equal() {
  my ($self, $other) = @_;
  if( UNIVERSAL::isa($other, 'Search::Xapian::PositionIterator') ) {
    Search::Xapianc::PositionIterator_equal1($self, $other);
  } else {
    ($self+0) == ($other+0);
  }
}

sub nequal() {
  my ($self, $other) = @_;
  if( UNIVERSAL::isa($other, 'Search::Xapian::PositionIterator') ) {
    Search::Xapianc::PositionIterator_nequal1($self, $other);
  } else {
    ($self+0) != ($other+0);
  }
}

package Search::Xapian::TermGenerator;
sub set_stopper {
    my ($self, $stopper) = @_;
    $self{_stopper} = $stopper;
    set_stopper1( @_ );
}

package Search::Xapian::TermIterator;
use overload '++' => sub { $_[0]->increment() },
             '='  => sub { $_[0]->clone() },
	     'eq' => sub { $_[0]->equal($_[1]) },
	     'ne' => sub { $_[0]->nequal($_[1]) },
	     '==' => sub { $_[0]->equal($_[1]) },
	     '!=' => sub { $_[0]->nequal($_[1]) },
             'fallback' => 1;

sub clone() {
  my $self = shift;
  my $class = ref( $self );
  my $copy = new( $self );
  bless $copy, $class;
  return $copy;
}

package Search::Xapian::ValueIterator;
use overload '++' => sub { $_[0]->increment() },
             '='  => sub { $_[0]->clone() },
	     'eq' => sub { $_[0]->equal($_[1]) },
	     'ne' => sub { $_[0]->nequal($_[1]) },
	     '==' => sub { $_[0]->equal($_[1]) },
	     '!=' => sub { $_[0]->nequal($_[1]) },
             'fallback' => 1;

sub clone() {
  my $self = shift;
  my $class = ref( $self );
  my $copy = new( $self );
  bless $copy, $class;
  return $copy;
}

# Adding CLONE_SKIP functions
package Search::Xapian::LogicError;
sub CLONE_SKIP { 1 }
package Search::Xapian::PositionIterator;
sub CLONE_SKIP { 1 }
package Search::Xapian::PostingIterator;
sub CLONE_SKIP { 1 }
package Search::Xapian::TermIterator;
sub CLONE_SKIP { 1 }
package Search::Xapian::ValueIterator;
sub CLONE_SKIP { 1 }
package Search::Xapian::Document;
sub CLONE_SKIP { 1 }
package Search::Xapian::PostingSource;
sub CLONE_SKIP { 1 }
package Search::Xapian::ValuePostingSource;
sub CLONE_SKIP { 1 }
package Search::Xapian::ValueWeightPostingSource;
sub CLONE_SKIP { 1 }
package Search::Xapian::ValueMapPostingSource;
sub CLONE_SKIP { 1 }
package Search::Xapian::FixedWeightPostingSource;
sub CLONE_SKIP { 1 }
package Search::Xapian::MSet;
sub CLONE_SKIP { 1 }
package Search::Xapian::MSetIterator;
sub CLONE_SKIP { 1 }
package Search::Xapian::ESet;
sub CLONE_SKIP { 1 }
package Search::Xapian::ESetIterator;
sub CLONE_SKIP { 1 }
package Search::Xapian::RSet;
sub CLONE_SKIP { 1 }
package Search::Xapian::MatchDecider;
sub CLONE_SKIP { 1 }
package Search::Xapian::Enquire;
sub CLONE_SKIP { 1 }
package Search::Xapian::Weight;
sub CLONE_SKIP { 1 }
package Search::Xapian::BoolWeight;
sub CLONE_SKIP { 1 }
package Search::Xapian::BM25Weight;
sub CLONE_SKIP { 1 }
package Search::Xapian::TradWeight;
sub CLONE_SKIP { 1 }
package Search::Xapian::Database;
sub CLONE_SKIP { 1 }
package Search::Xapian::WritableDatabase;
sub CLONE_SKIP { 1 }
package Search::Xapian::Query;
sub MatchAll { Search::Xapianc::new_Query('') }
sub MatchNothing { Search::Xapianc::new_Query() }
sub CLONE_SKIP { 1 }
package Search::Xapian::Stopper;
sub CLONE_SKIP { 1 }
package Search::Xapian::SimpleStopper;
sub CLONE_SKIP { 1 }
package Search::Xapian::ValueRangeProcessor;
sub CLONE_SKIP { 1 }
package Search::Xapian::StringValueRangeProcessor;
sub CLONE_SKIP { 1 }
package Search::Xapian::DateValueRangeProcessor;
sub CLONE_SKIP { 1 }
package Search::Xapian::NumberValueRangeProcessor;
sub CLONE_SKIP { 1 }
package Search::Xapian::QueryParser;
sub CLONE_SKIP { 1 }
package Search::Xapian::Stem;
sub CLONE_SKIP { 1 }
package Search::Xapian::TermGenerator;
sub CLONE_SKIP { 1 }
package Search::Xapian::Sorter;
sub CLONE_SKIP { 1 }
package Search::Xapian::MultiValueSorter;
sub CLONE_SKIP { 1 }
package Search::Xapian::ReplicationInfo;
sub CLONE_SKIP { 1 }
package Search::Xapian::DatabaseMaster;
sub CLONE_SKIP { 1 }
package Search::Xapian::DatabaseReplica;
sub CLONE_SKIP { 1 }
package Search::Xapian::ValueSetMatchDecider;
sub CLONE_SKIP { 1 }
package Search::Xapian::SerialisationContext;
sub CLONE_SKIP { 1 }
package Search::Xapian::MSet::Tied;
sub CLONE_SKIP { 1 }

# Pod document of Search::Xapian
=head1 NAME

Search::Xapian - Perl frontend to the Xapian C++ search library.

=head1 SYNOPSIS

  use Search::Xapian;

  my $db = Search::Xapian::Database->new( '[DATABASE DIR]' );
  my $enq = $db->enquire( '[QUERY TERM]' );

  printf "Running query '%s'\n", $enq->get_query()->get_description();

  my @matches = $enq->matches(0, 10);

  print scalar(@matches) . " results found\n";

  foreach my $match ( @matches ) {
    my $doc = $match->get_document();
    printf "ID %d %d%% [ %s ]\n", $match->get_docid(), $match->get_percent(), $doc->get_data();
  }

=head1 DESCRIPTION

This module wraps most methods of most Xapian classes. The missing classes
and methods should be added in the future. It also provides a simplified,
more 'perlish' interface to some common operations, as demonstrated above.

There are some gaps in the POD documentation for wrapped classes, but you
can read the Xapian C++ API documentation at
L<http://xapian.org/docs/apidoc/html/annotated.html> for details of
these.  Alternatively, take a look at the code in the examples and tests.

If you want to use Search::Xapian and the threads module together, make
sure you're using Search::Xapian >= 1.0.4.0 and Perl >= 5.8.7.  As of 1.0.4.0,
Search::Xapian uses CLONE_SKIP to make sure that the perl wrapper objects
aren't copied to new threads - without this the underlying C++ objects can get
destroyed more than once.

If you encounter problems, or have any comments, suggestions, patches, etc
please email the Xapian-discuss mailing list (details of which can be found at
L<http://xapian.org/lists>).

=head2 EXPORT

None by default.

=head1 :db

=over 4

=item DB_OPEN

Open a database, fail if database doesn't exist.

=item DB_CREATE

Create a new database, fail if database exists.

=item DB_CREATE_OR_OPEN

Open an existing database, without destroying data, or create a new
database if one doesn't already exist.

=item DB_CREATE_OR_OVERWRITE

Overwrite database if it exists.

=back

=head1 :ops

=over 4

=item OP_AND

Match if both subqueries are satisfied.

=item OP_OR

Match if either subquery is satisfied.

=item OP_AND_NOT

Match if left but not right subquery is satisfied.

=item OP_XOR

Match if left or right, but not both queries are satisfied.

=item OP_AND_MAYBE

Match if left is satisfied, but use weights from both.

=item OP_FILTER

Like OP_AND, but only weight using the left query.

=item OP_NEAR

Match if the words are near each other. The window should be specified, as
a parameter to C<Search::Xapian::Query::Query>, but it defaults to the
number of terms in the list.

=item OP_PHRASE

Match as a phrase (All words in order).

=item OP_ELITE_SET

Select an elite set from the subqueries, and perform a query with these combined as an OR query.

=item OP_VALUE_RANGE

Filter by a range test on a document value.

=back

=head1 :qpflags

=over 4

=item FLAG_DEFAULT

This gives the QueryParser default flag settings, allowing you to easily add
flags to the default ones.

=item FLAG_BOOLEAN

Support AND, OR, etc and bracketted subexpressions.

=item FLAG_LOVEHATE

Support + and -.

=item FLAG_PHRASE

Support quoted phrases.

=item FLAG_BOOLEAN_ANY_CASE

Support AND, OR, etc even if they aren't in ALLCAPS.

=item FLAG_WILDCARD

Support right truncation (e.g. Xap*).

=item FLAG_PURE_NOT

Allow queries such as 'NOT apples'.

These require the use of a list of all documents in the database
which is potentially expensive, so this feature isn't enabled by
default.

=item FLAG_PARTIAL

Enable partial matching.

Partial matching causes the parser to treat the query as a
"partially entered" search.  This will automatically treat the
final word as a wildcarded match, unless it is followed by
whitespace, to produce more stable results from interactive
searches.

=item FLAG_SPELLING_CORRECTION

=item FLAG_SYNONYM

=item FLAG_AUTO_SYNONYMS

=item FLAG_AUTO_MULTIWORD_SYNONYMS

=back

=head1 :qpstem

=over 4

=item STEM_ALL

Stem all terms.

=item STEM_NONE

Don't stem any terms.

=item STEM_SOME

Stem some terms, in a manner compatible with Omega (capitalised words and those
in phrases aren't stemmed).

=back

=head1 :enq_order

=over 4

=item ENQ_ASCENDING

docids sort in ascending order (default)

=item ENQ_DESCENDING

docids sort in descending order

=item ENQ_DONT_CARE

docids sort in whatever order is most efficient for the backend

=back

=head1 :standard

Standard is db + ops + qpflags + qpstem

=head1 Version functions

=over 4

=item major_version

Returns the major version of the Xapian C++ library being used.  E.g. for
Xapian 1.0.9 this would return 1.

=item minor_version

Returns the minor version of the Xapian C++ library being used.  E.g. for
Xapian 1.0.9 this would return 0.

=item revision

Returns the revision of the Xapian C++ library being used.  E.g. for
Xapian 1.0.9 this would return 9.  In a stable release series, Xapian libraries
with the same minor and major versions are usually ABI compatible, so this
often won't match the third component of $Search::Xapian::VERSION (which is the
version of the Search::Xapian wrappers).

=back

=head1 Numeric encoding functions

=over 4

=item sortable_serialise NUMBER

Convert a floating point number to a string, preserving sort order.

This method converts a floating point number to a string, suitable for
using as a value for numeric range restriction, or for use as a sort
key.

The conversion is platform independent.

The conversion attempts to ensure that, for any pair of values supplied
to the conversion algorithm, the result of comparing the original
values (with a numeric comparison operator) will be the same as the
result of comparing the resulting values (with a string comparison
operator).  On platforms which represent doubles with the precisions
specified by IEEE_754, this will be the case: if the representation of
doubles is more precise, it is possible that two very close doubles
will be mapped to the same string, so will compare equal.

Note also that both zero and -zero will be converted to the same
representation: since these compare equal, this satisfies the
comparison constraint, but it's worth knowing this if you wish to use
the encoding in some situation where this distinction matters.

Handling of NaN isn't (currently) guaranteed to be sensible.

=item sortable_unserialise SERIALISED_NUMBER

Convert a string encoded using sortable_serialise back to a floating
point number.

This expects the input to be a string produced by sortable_serialise().
If the input is not such a string, the value returned is undefined (but
no error will be thrown).

The result of the conversion will be exactly the value which was
supplied to sortable_serialise() when making the string on platforms
which represent doubles with the precisions specified by IEEE_754, but
may be a different (nearby) value on other platforms.

=back

=head1 TODO

=over 4

=item Error Handling

Error handling for all methods liable to generate them.

=item Documentation

Add POD documentation for all classes, where possible just adapted from Xapian
docs.

=item Unwrapped classes

The following Xapian classes are not yet wrapped:
Error (and subclasses), ErrorHandler, ExpandDecider (and subclasses),
user-defined weight classes.

We don't yet wrap Xapian::BAD_VALUENO.

=item Unwrapped methods

The following methods are not yet wrapped:
Enquire::get_eset(...) with more than two arguments,
Query ctor optional "parameter" parameter,
Remote::open(...),
static Stem::get_available_languages().

We wrap MSet::swap() and MSet::operator[](), but not ESet::swap(),
ESet::operator[]().  Is swap actually useful?  Should we instead tie MSet
and ESet to allow them to just be used as lists?

=back

=head1 CREDITS

Thanks to Tye McQueen E<lt>tye@metronet.comE<gt> for explaining the
finer points of how best to write XS frontends to C++ libraries, James
Aylett E<lt>james@tartarus.orgE<gt> for clarifying the less obvious
aspects of the Xapian API, Tim Brody for patches wrapping ::QueryParser and
::Stopper and especially Olly Betts E<lt>olly@survex.comE<gt> for contributing
advice, bugfixes, and wrapper code for the more obscure classes.

=head1 AUTHOR

Alex Bowley E<lt>kilinrax@cpan.orgE<gt>

Please report any bugs/suggestions to E<lt>xapian-discuss@lists.xapian.orgE<gt>
or use the Xapian bug tracker L<http://xapian.org/bugs>.  Please do
NOT use the CPAN bug tracker or mail any of the authors individually.

=head1 SEE ALSO

L<Search::Xapian::BM25Weight>,
L<Search::Xapian::BoolWeight>,
L<Search::Xapian::Database>,
L<Search::Xapian::Document>,
L<Search::Xapian::Enquire>,
L<Search::Xapian::MultiValueSorter>,
L<Search::Xapian::PositionIterator>,
L<Search::Xapian::PostingIterator>,
L<Search::Xapian::QueryParser>,
L<Search::Xapian::Stem>,
L<Search::Xapian::TermGenerator>,
L<Search::Xapian::TermIterator>,
L<Search::Xapian::TradWeight>,
L<Search::Xapian::ValueIterator>,
L<Search::Xapian::Weight>,
L<Search::Xapian::WritableDatabase>,
and
L<http://xapian.org/>.

=cut
%}
