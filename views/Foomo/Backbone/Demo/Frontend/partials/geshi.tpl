<?

if(class_exists('GeSHi')) {
	$geshi = new \GeSHi($code, $language);
	$geshi->keyword_links = false;
	$geshi->enable_line_numbers(GESHI_NORMAL_LINE_NUMBERS);
	$geshi->set_header_type(GESHI_HEADER_DIV);
	$geshi->set_line_style('font-size:12px');
	$geshi->set_tab_width(4);
	echo $geshi->parse_code();
} else {
	highlight_string($code);
}

?>