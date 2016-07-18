=head1 NAME

Locale::SubCountry - Convert state, province, county etc. names to/from ISO 3166-2 codes

=head1 SYNOPSIS

    my $country_code = 'GB';
    my $UK = Locale::SubCountry->new($country_code);
    if ( not $UK )
    {
        die "Invalid code $country_code\n";
    }
    elsif (  $UK->has_sub_countries )
    {
        print($UK->full_name('DGY'),"\n");           # Dumfries and Galloway
        print($UK->regional_division('DGY'),"\n");   # SCT (Scotland)
    }

    my $australia = Locale::SubCountry->new('Australia');
    if ( not $australia )
    {
        die "Invalid code: Australia\n";
    }
    else
    {
        print($australia->country,"\n");        # Australia
        print($australia->country_code,"\n");   # AU

        if (  $australia->has_sub_countries )
        {
            print($australia->code('New South Wales '),"\n");     # NSW
            print($australia->full_name('S.A.'),"\n");            # South Australia
            my $upper_case = 1;
            print($australia->full_name('Qld',$upper_case),"\n"); # QUEENSLAND
            print($australia->category('NSW'),"\n");              # state
            print($australia->FIPS10_4_code('ACT'),"\n");         # 01
            print($australia->ISO3166_2_code('02'),"\n");         # NSW

            my @aus_state_names  = $australia->all_full_names;
            my @aus_code_names   = $australia->all_codes;
            my %aus_states_keyed_by_code  = $australia->code_full_name_hash;
            my %aus_states_keyed_by_name  = $australia->full_name_code_hash;

            foreach my $code ( sort keys %aus_states_keyed_by_code )
            {
               printf("%-3s : %s\n",$code,$aus_states_keyed_by_code{$code});
            }
        }
    }

    # Methods for country codes and names

    my $world = Locale::SubCountry::World->new();
    my @all_countries     = $world->all_full_names;
    my @all_country_codes = $world->all_codes;

    my %all_countries_keyed_by_name = $world->full_name_code_hash;
    my %all_country_keyed_by_code   = $world->code_full_name_hash;


=head1 DESCRIPTION

This module allows you to convert the full name for a countries administrative
region to the code commonly used for postal addressing. The reverse lookup
can also be done. Sub country codes are defined in "ISO 3166-2:2007,
Codes for the representation of names of countries and their subdivisions".

Sub countries are termed as states in the US and Australia, provinces
in Canada and counties in the UK and Ireland. Other terms include region,
department, city and territory.

Names and ISO 3166-2 codes for all sub countries in a country can be
returned as either a hash or an array.

Names and ISO 3166-1 codes for all countries in the world can be
returned as either a hash or an array.

ISO 3166-2 codes can be converted to FIPS 10-4 codes. The reverse lookup can
also be done.

=head1 METHODS

Note that the following methods duplicate some of the functionality of the
Locale::Country module (part of the Locale::Codes bundle). They are provided
here because you may need to first access the list of available countries and
ISO 3166-1 codes, before fetching their sub country data. If you only need
access to country data, then Locale::Country should be used.

Note also the following method names are also used for sub country objects.
(interface polymorphism for the technically minded). To avoid confusion, make
sure that your chosen method is acting on the correct type of object.

    all_codes
    all_full_names
    code_full_name_hash
    full_name_code_hash


=head2  Locale::SubCountry::World->new()

The C<new> method creates an instance of a world country object. This must be
called before any of the following methods are invoked. The method takes no
arguments.


=head2 full_name_code_hash (for world objects)

Given a world object, returns a hash of full name/code pairs for every country,
keyed by country name.

=head2 code_full_name_hash  for world objects)

Given a world object, returns a hash of full name/code pairs for every country,
keyed by country code.


=head2 all_full_names (for world objects)

Given a world object, returns an array of all country full names,
sorted alphabetically.

=head2 all_codes (for world objects)

Given a world object, returns an array of all country IS) 3166-1 codes,
sorted alphabetically.


=head2 Locale::SubCountry->new()

The C<new> method creates an instance of a sub country object. This must be
called before any of the following methods are invoked. The method takes a
single argument, the name of the country that contains the sub country
that you want to work with. It may be specified either by the ISO 3166-1
two letter code or the full name. For example:

    AF - Afghanistan
    AL - Albania
    DZ - Algeria
    AO - Angola
    AR - Argentina
    AM - Armenia
    AU - Australia
    AT - Austria


If the code is specified, such as 'AU'  the format may be in  capitals or lower case
If the full name is specified, such as 'Australia', the format must be in title case
If a country name or code is specified that the module doesn't recognised, it will issue a warning.

=head2 country

Returns the current country of a sub country object, the format is title case

=head2 country_code

Given a sub country object, returns the two letter ISO 3166-1 code of the country


=head2 code

Given a sub country object, the C<code> method takes the full name of a sub
country and returns the sub country's ISO 3166-2 code. The full name can appear
in mixed case. All white space and non alphabetic characters are ignored, except
the single space used to separate sub country names such as "New South Wales".
The code is returned as a capitalised string, or "unknown" if no match is found.

=head2 full_name

Given a sub country object, the C<full_name> method takes the ISO 3166-2 code of
a sub country and returns the sub country's full name. The code can appear
in mixed case. All white space and non alphabetic characters are ignored. The
full name is returned as a title cased string, such as "South Australia".

If an optional argument is supplied and set to a true value, the full name is
returned as an upper cased string.

=head2 category

Given a sub country object, the C<category> method takes the ISO 3166-2 code of
a sub country and returns the sub country's category type. Examples are city,
province,state and district. The category is returned as a capitalised string,
or "unknown" if no match is found.

=head2 regional_division

Given a sub country object, the C<regional_division> method takes the
ISO 3166-2 code of a sub country and returns the sub country's
regional_division. This is an alphanumeric code. The regional_division
is returned as a capitalised string,  or "unknown" if no match is found.

=head2 has_sub_countries

Given a sub country object, the C<has_sub_countries> method returns 1 if the
current country has sub countries, or 0 if it does not. Some small countries
such as Singapore do not have sub countries.

=head2 FIPS10_4_code

NOTE: On September 2, 2008, FIPS 10-4 was one of ten standards withdrawn by NIST as a
Federal Information Processing Standard. It may not be supported by this module in
the future.

Given a sub country object, the C<FIPS_10_4_code> method takes the ISO 3166-2 code
of a sub country and returns the sub country's FIPS 10-4 code, or the string 'unknown',
if none exists. FIPS is a standard  developed by the US government.

=head2 ISO3166_2_code

Given a sub country object, the C<ISO3166_2_code> method takes the FIPS 10-4 code
of a sub country and returns the sub country's ISO 3166-2 code, or the string 'unknown',
if none exists.


=head2 full_name_code_hash  (for subcountry objects)

Given a sub country object, returns a hash of all full name/code pairs,
keyed by sub country name. If the country has no sub countries, returns undef.

=head2 code_full_name_hash  (for subcountry objects)

Given a sub country object, returns a hash of all code/full name pairs,
keyed by sub country code. If the country has no sub countries, returns undef.


=head2 all_full_names  (for subcountry objects)

Given a sub country object, returns an array of all sub country full names,
sorted alphabetically. If the country has no sub countries, returns undef.

=head2 all_codes  (for subcountry objects)

Given a sub country object, returns an array of all sub country ISO 3166-2 codes,
sorted alphabetically. If the country has no sub countries, returns undef.



=head1 SEE ALSO

L<Locale::Country>,L<Lingua::EN::AddressParse>,
L<Geo::StreetAddress::US>,L<Geo::PostalAddress>,L<Geo::IP>
L<WWW::Scraper::Wikipedia::ISO3166> for obtaining ISO 3166-2 data

ISO 3166-1:2007 Codes for the representation of names of countries and their
subdivisions - Part 1: Country codes

ISO 3166-2:2007 Codes for the representation of names of countries and their
subdivisions - Part 2: Country subdivision code
Also released as AS/NZS 2632.2:1999

Federal Information Processing Standards Publication 10-4
1995 April Specifications for  COUNTRIES, DEPENDENCIES, AREAS OF SPECIAL SOVEREIGNTY,
AND THEIR PRINCIPAL ADMINISTRATIVE DIVISIONS

L<http://www.statoids.com/statoids.html> is a good source for sub country codes plus
other statistical data.




=head1 LIMITATIONS

ISO 3166-2:2007 defines all sub country codes as being up to 3 letters and/or
numbers. These codes are commonly accepted for countries like the USA
and Canada. In Australia  this method of abbreviation is not widely accepted.
For example, the ISO code for 'New South Wales' is 'NS', but 'NSW' is the
abbreviation that is most commonly used. I could add a flag to enforce
ISO-3166-2 codes if needed.

The ISO 3166-2 standard romanizes the names of provinces and regions in non-latin
script areas, such as Russia and South Korea. One Romanisation is given for each
province name. For Russia, the BGN (1947) Romanization is used.

Several sub country names have more than one code, and may not return
the correct code for that sub country. These entries are usually duplicated
because the name represents two different types of sub country, such as a
province and a geographical unit. Examples are:

    AZERBAIJAN : Lankaran; LA (the City), LAN (the Rayon) [see note]
    AZERBAIJAN : Saki; SA,SAK [see note]
    AZERBAIJAN : Susa; SS,SUS
    AZERBAIJAN : Yevlax; YE,YEV
    INDONESIA  : Kalimantan Timur; KI,KT
    LAOS       : Vientiane VI,VT
    MOLDOVA    : Hahul; CA,CHL
    MOLDOVA    : Bubasari; DU,DBI
    MOLDOVA    : Hrhei; OR,OHI
    MOLDOVA    : Coroca; SO,SOA
    MOLDOVA    : Gngheni; UN,UGI
    MOZAMBIQUE : Maputo; MPM,L

Note: these names are spelt with a diaeresis character (two dots) above
some of the 'a' characters. This causes utf8 errors on some versions
of Perl, so they are omitted here. See the Locale::SubCountry::Data module
for correct spelling

FIPS codes are not provided for all sub countries.


=head1 AUTHOR

Locale::SubCountry was written by Kim Ryan <kimryan at cpan dot org>.


=head1 CREDITS

Ron Savage for many corrections to the data

Alastair McKinstry provided many of the sub country codes and names.

Terrence Brannon produced Locale::US, which was the starting point for
this module.

Mark Summerfield and Guy Fraser provided the list of UK counties.

TJ Mather supplied the FIPS codes and many amendments to the sub country data


=head1 COPYRIGHT AND LICENSE

Copyright (c) 2015 Kim Ryan. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

#-------------------------------------------------------------------------------

use strict;
use warnings;
use locale;
use Exporter;
use Locale::SubCountry::Data;

#-------------------------------------------------------------------------------

package Locale::SubCountry::World;
our $VERSION = '1.65';

# Define all the methods for the 'world' class here. Note that because the
# name space inherits from the Locale::SubCountry name space, the
# package wide variables $SubCountry::country_lookup and $Locale::SubCountry::subcountry_lookup are
# accessible.


#-------------------------------------------------------------------------------
# Create new instance of a SubCountry::World object

sub new
{
    my $class = shift;

    my $world = {};
    bless($world,$class);
    return($world);
}

#-------------------------------------------------------------------------------
# Returns a hash of code/name pairs for all countries, keyed by  country code.

sub code_full_name_hash
{
    my $world = shift;
    return(  %{ $Locale::SubCountry::country_lookup{_code_keyed} } );
}
#-------------------------------------------------------------------------------
# Returns a hash of name/code pairs for all countries, keyed by country name.

sub full_name_code_hash
{
    my $world = shift;
    return( %{ $Locale::SubCountry::country_lookup{_full_name_keyed} } );
}
#-------------------------------------------------------------------------------
# Returns sorted array of all country full names

sub all_full_names
{
    my $world = shift;
    return ( sort keys %{ $Locale::SubCountry::country_lookup{_full_name_keyed} });
}
#-------------------------------------------------------------------------------
# Returns sorted array of all two letter country codes

sub all_codes
{
    my $world = shift;
    return ( sort keys %{ $Locale::SubCountry::country_lookup{_code_keyed} });
}

#-------------------------------------------------------------------------------

package Locale::SubCountry;
our $VERSION = '1.65';

#-------------------------------------------------------------------------------
# Initialization code must be run first to create global data structure.
# Read in the list of abbreviations and full names defined in the
# Locale::SubCountry::Data package

{

    unless ( $Locale::SubCountry::Data::xml_data )
    {
      die "Could not locate Locale::SubCountry::Data::xml_data variable";
    }

    # Get all the data from the Locale::SubCountryData pakage and place into an array of lines
    my @lines = split(/\n/,$Locale::SubCountry::Data::xml_data);

    while ( @lines )
    {
        my $current_line = shift(@lines);

        # Data is in XML format, use a simple parser to extract it
        my ($country_name,$country_code);
        if ( $current_line =~ /<country>/ )
        {
            # start of a  <country> .. </country> block
            my $country_finished = 0;
            until ( $country_finished )
            {
                $current_line = shift(@lines);
                if ( $current_line =~ /\s*<name>(.*)<\/name>/ )
                {
                    $country_name = $1;
                }
                elsif ( $current_line =~ /\s*<code>(.*)<\/code>/ )
                {
                    $country_code = $1;
                }
                elsif ( $current_line =~ /<subcountry>/ )
                {
                    my $sub_country_finished = 0;

                    my ($sub_country_name,$sub_country_code,$category,$regional_division,$FIPS_code);
                    until ( $sub_country_finished )
                    {
                        $current_line = shift(@lines);
                        if ( $current_line =~ /\s*<name>(.*)<\/name>/ )
                        {
                            $sub_country_name = $1;
                        }
                        elsif ( $current_line =~ /\s*<code>(.*)<\/code>/ )
                        {
                            $sub_country_code = $1;
                        }
                        elsif ( $current_line =~ /\s*<FIPS>(.*)<\/FIPS>/ )
                        {
                            $FIPS_code = $1;
                        }
                        elsif ( $current_line =~ /\s*<category>(.*)<\/category>/ )
                        {
                            $category = $1;
                        }
                        elsif ( $current_line =~ /\s*<regional_division>(.*)<\/regional_division>/ )
                        {
                            $regional_division = $1;
                        }
                        elsif ( $current_line =~ /<\/subcountry>/ )
                        {

                            $sub_country_finished = 1;

                            # Some sub countries have no ISO code, such as Shariff Kabunsuan in the
                            # Phillipines. Only index sub country if it has a code
                            if ( defined $sub_country_code )
                            {
                                # Insert into doubly indexed hash, grouped by country for ISO 3166-2
                                # codes. One hash is keyed by abbreviation and one by full name. Although
                                # data is duplicated, this provides the fastest lookup and simplest code.

                                $Locale::SubCountry::subcountry_lookup{$country_name}{_code_keyed}{$sub_country_code} = $sub_country_name;
                                $Locale::SubCountry::subcountry_lookup{$country_name}{_full_name_keyed}{$sub_country_name} = $sub_country_code;
                            }

                            if ( $category )
                            {
                                $Locale::SubCountry::subcountry_lookup{$country_name}{$sub_country_code}{_category} = $category;
                            }

                            if ( $regional_division )
                            {
                                $Locale::SubCountry::subcountry_lookup{$country_name}{$sub_country_code}{_regional_division} = $regional_division;
                            }

                            if ( $FIPS_code )
                            {
                                # Insert into doubly indexed hash, grouped by country for FIPS 10-4 codes
                                $Locale::SubCountry::subcountry_lookup{$country_name}{_FIPS10_4_code_keyed}{$FIPS_code} = $sub_country_code;
                                $Locale::SubCountry::subcountry_lookup{$country_name}{_ISO3166_2_code_keyed}{$sub_country_code} = $FIPS_code;
                            }
                        }
                        elsif ( $current_line =~ /\w.*/ )
                        {
                            die "Badly formed XML sub country data in $country_name\nData: $current_line\n";
                        }
                    }
                }
                elsif ( $current_line =~ /<\/country>/ )
                {
                    $country_finished = 1;

                    # Create doubly indexed hash, keyed by  country code and full name.
                    # The user can supply either form to create a new sub_country
                    # object, and the objects properties will hold both the countries
                    # name and it's code.

                    $Locale::SubCountry::country_lookup{_code_keyed}{$country_code} = $country_name;
                    $Locale::SubCountry::country_lookup{_full_name_keyed}{$country_name} = $country_code;

                }
                elsif ( $current_line =~ /\w.*/ )
                {
                    die "Badly formed XML country data in $country_name\nData: $current_line\n";
                }
            }
        }
    }
}

#-------------------------------------------------------------------------------
# Create new instance of a sub country object

sub new
{
    my $class = shift;
    my ($country_or_code) = @_;


    my ($country,$country_code);


    # Country may be supplied either as a two letter code, or the full name
    if ( length($country_or_code) == 2 )
    {
        $country_or_code = uc($country_or_code); # lower case codes may be used, so fold to upper case
        if ( $Locale::SubCountry::country_lookup{_code_keyed}{$country_or_code} )
        {
            $country_code = $country_or_code;
            # set country to it's full name
            $country = $Locale::SubCountry::country_lookup{_code_keyed}{$country_code};
         }
        else
        {
          warn "Invalid country code: $country_or_code chosen";
          return(undef);
        }
    }
    else
    {
        if ( $Locale::SubCountry::country_lookup{_full_name_keyed}{$country_or_code} )
        {
            $country = $country_or_code;
            $country_code = $Locale::SubCountry::country_lookup{_full_name_keyed}{$country};
        }
        else
        {
            warn "Invalid country name: $country_or_code chosen, names must be in title case";
            return(undef);

        }
    }

    my $sub_country = {};
    bless($sub_country,$class);
    $sub_country->{_country} = $country;
    $sub_country->{_country_code} = $country_code;


    return($sub_country);
}

#-------------------------------------------------------------------------------
# Returns the current country of the sub country object

sub country
{
    my $sub_country = shift;
    return( $sub_country->{_country} );
}
#-------------------------------------------------------------------------------
# Returns the current country code of the sub country object

sub country_code
{
    my $sub_country = shift;
    return( $sub_country->{_country_code} );
}

#-------------------------------------------------------------------------------
# Given the full name for a sub country, return the ISO 3166-2 code

sub code
{
    my $sub_country = shift;
    my ($full_name) = @_;

    unless ( $sub_country->has_sub_countries )
    {
        # this country has no sub countries
        return;
    }

    my $orig = $full_name;

    $full_name = _clean($full_name);

    my $code = $Locale::SubCountry::subcountry_lookup{$sub_country->{_country}}{_full_name_keyed}{$full_name};

    # If a code wasn't found, it could be because the user's capitalization
    # does not match the one in the look up data of this module. For example,
    # the user may have supplied the sub country "Ag R" (in Turkey) but the
    # ISO standard defines the spelling as "Ag r".

    unless ( defined $code )
    {
        # For every sub country, compare upper cased full name supplied by user
        # to upper cased full name from lookup hash. If they match, return the
        # correctly cased full name from the lookup hash.

        my @all_names = $sub_country->all_full_names;
        my $current_name;
        foreach $current_name ( @all_names )
        {
            if ( uc($full_name) eq uc($current_name) )
            {
                $code = $Locale::SubCountry::subcountry_lookup{$sub_country->{_country}}{_full_name_keyed}{$current_name};
            }
        }
    }

    if ( defined $code )
    {
        return($code);
    }
    else
    {
        return('unknown');
    }
}
#-------------------------------------------------------------------------------
# Given the ISO 3166-2 code for a sub country, return the FIPS 104-4 code.

sub FIPS10_4_code
{
    my $sub_country = shift;
    my ($code) = @_;

    $code = _clean($code);
    $code = uc($code);

    my $FIPS_code = $Locale::SubCountry::subcountry_lookup{$sub_country->{_country}}{_ISO3166_2_code_keyed}{$code};

    if ( $FIPS_code )
    {
        return($FIPS_code);
    }
    else
    {
        return('unknown');
    }
}
#-------------------------------------------------------------------------------
# Given the FIPS 10-4 code for a sub country, return the ISO 3166-2 code.

sub ISO3166_2_code
{
    my $sub_country = shift;
    my ($FIPS_code) = @_;

    $FIPS_code = _clean($FIPS_code);

    my $code = $Locale::SubCountry::subcountry_lookup{$sub_country->{_country}}{_FIPS10_4_code_keyed}{$FIPS_code};

    if ( $code )
    {
        return($code);
    }
    else
    {
        return('unknown');
    }
}
#-------------------------------------------------------------------------------
# Given the ISO 3166-2 code for a sub country, return the category,
# being state, province, city, council etc

sub category
{
    my $sub_country = shift;
    my ($code) = @_;

    $code = _clean($code);

    my $category = $Locale::SubCountry::subcountry_lookup{$sub_country->{_country}}{$code}{_category};

    if ( $category )
    {
        return($category);
    }
    else
    {
        return('unknown');
    }
}

#-------------------------------------------------------------------------------
# Given the ISO 3166-2 code for a sub country, return the regional division,

sub regional_division
{
    my $sub_country = shift;
    my ($code) = @_;

    $code = _clean($code);

    my $regional_division = $Locale::SubCountry::subcountry_lookup{$sub_country->{_country}}{$code}{_regional_division};

    if ( $regional_division )
    {
        return($regional_division);
    }
    else
    {
        return('unknown');
    }
}

#-------------------------------------------------------------------------------
# Given the ISO 3166-2 code for a sub country, return the full name.
# Parameters are the code and a flag, which if set to true
# will cause the full name to be uppercased

sub full_name
{
    my $sub_country = shift;
    my ($code,$uc_name) = @_;

    unless ( $sub_country->has_sub_countries )
    {
        # this country has no sub countries
        return;
    }

    $code = _clean($code);
    $code = uc($code);

    my $full_name =
        $Locale::SubCountry::subcountry_lookup{$sub_country->{_country}}{_code_keyed}{$code};
    if ( $uc_name )
    {
        $full_name = uc($full_name);
    }

    if ( $full_name )
    {
        return($full_name);
    }
    else
    {
        return('unknown');
    }
}
#-------------------------------------------------------------------------------
# Returns 1 if the current country has sub countries. otherwise 0.

sub has_sub_countries
{
    my $sub_country = shift;
    if ( $Locale::SubCountry::subcountry_lookup{$sub_country->{_country}}{_code_keyed} )
    {
        return(1);
    }
    else
    {
        return(0);
    }
}
#-------------------------------------------------------------------------------
# Returns a hash of code/full name pairs, keyed by sub country code.

sub code_full_name_hash
{
    my $sub_country = shift;
    if ( $sub_country->has_sub_countries )
    {
        return( %{ $Locale::SubCountry::subcountry_lookup{$sub_country->{_country}}{_code_keyed} } );
    }
    else
    {
        return(undef);
    }
}
#-------------------------------------------------------------------------------
# Returns a hash of name/code pairs, keyed by sub country name.

sub full_name_code_hash
{
    my $sub_country = shift;
    if ( $sub_country->has_sub_countries )
    {
        return( %{ $Locale::SubCountry::subcountry_lookup{$sub_country->{_country}}{_full_name_keyed} } );
    }
    else
    {
        return(undef);
    }
}
#-------------------------------------------------------------------------------
# Returns sorted array of all sub country full names for the current country

sub all_full_names
{
    my $sub_country = shift;
    if ( $sub_country->full_name_code_hash )
    {
        my %all_full_names = $sub_country->full_name_code_hash;
        if ( %all_full_names )
        {
            return( sort keys %all_full_names );
        }
    }
    else
    {
        return(undef);
    }
}
#-------------------------------------------------------------------------------
# Returns sorted array of all sub country ISO 3166-2 codes for the current country

sub all_codes
{
    my $sub_country = shift;

    if ( $sub_country->code_full_name_hash )
    {
        my %all_codes = $sub_country->code_full_name_hash;
        return( sort keys %all_codes );
    }
    else
    {
        return(undef);
    }
}

#-------------------------------------------------------------------------------
sub _clean
{
    my ($input_string) = @_;

    if ( $input_string =~ /[\. ]/ )
    {
        # remove dots
        $input_string =~ s/\.//go;

        # remove repeating spaces
        $input_string =~ s/  +/ /go;

        # remove any remaining leading or trailing space
        $input_string =~ s/^ //;
        $input_string =~ s/ $//;
    }

    return($input_string);
}

return(1);
