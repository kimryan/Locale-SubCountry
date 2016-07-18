use Module::Build;

Module::Build -> new
(
 module_name    => 'Locale::SubCountry',
 license        => 'perl',
 dist_abstract  => "Convert state, province, county etc. names to/from ISO 3166-2 codes",
 dist_author    => 'Kim Ryan <kimryan at cpan org>',
 build_requires =>
 {
 	Test::More => 0.94,
 	Test::Pod  => 1.04,
 },
 configure_requires =>
 {
 	 Module::Build => 0.3800,
 },
 requires =>
 {
	locale              => 1.00,
	strict              => 0,
	Test::Pod::Coverage => 1.04,
	utf8                => 0,
	warnings            => 0,
 },
) -> create_build_script();
