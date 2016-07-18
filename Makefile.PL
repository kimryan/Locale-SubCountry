use 5.008004;
use ExtUtils::MakeMaker;


WriteMakefile
(
    'NAME'         => 'Locale::SubCountry',
    'VERSION_FROM' => 'lib/Locale/SubCountry.pm',
    'ABSTRACT'     => 'Convert state, province, county etc. names to/from ISO 3166-2 codes',
    'AUTHOR'       => 'Kim Ryan <kimryan at cpan org>',
    'LICENSE'      => 'perl',
    'PREREQ_PM'    =>
	{
	locale              => 1.00,
	strict              => 1.04,
 	Test::More          => 0.94,
 	Test::Pod           => 1.04,
	Test::Pod::Coverage => 1.04,
	utf8                => 1.09,
	warnings            => 1.12,
	},
);
