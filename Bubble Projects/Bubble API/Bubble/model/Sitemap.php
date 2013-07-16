<?php
class SitemapHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'Sitemap';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>