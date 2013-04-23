<?

if(class_exists('GeSHi')) {
	$geshi = new \GeSHi($code, $language);
	$geshi->enable_line_numbers(GESHI_NORMAL_LINE_NUMBERS);
	echo $geshi->parse_code();
} else {
	highlight_string($code);
}

?>