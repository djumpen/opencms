<?php
class Document {
	private $title;
	private $description;
	private $keywords;	
	private $links          = array();		
	private $styles         = array();
	private $scripts        = array();
	private $footer_scripts = array();
	private $footer_styles  = array();
	private $ts_scripts     = array();
	private $ts_requeire    = false;
	
	public function setTitle($title) {
		$this->title = $title;
	}
	
	public function getTitle() {
		return $this->title;
	}
	
	public function setDescription($description) {
		$this->description = $description;
	}
	
	public function getDescription() {
		return $this->description;
	}
	
	public function setKeywords($keywords) {
		$this->keywords = $keywords;
	}
	
	public function getKeywords() {
		return $this->keywords;
	}
	
	public function addLink($href, $rel) {
		$this->links[md5($href)] = array(
			'href' => $href,
			'rel'  => $rel
		);			
	}
	
	public function getLinks() {
		return $this->links;
	}	
	
	public function addStyle($href, $rel = 'stylesheet', $media = 'screen', $footer = false) {
		if(!$footer) {
			$this->styles[md5($href)] = array(
				'href'  => $href,
				'rel'   => $rel,
				'media' => $media,
			);
		} else {
			$this->footer_styles[md5($href)] = array(
				'href'  => $href,
				'rel'   => $rel,
				'media' => $media,
			);			
		}
	}
	
	public function addFooterStyle($href) {
		$this->addStyle($href, 'stylesheet', 'screen', true);
	}
	
	public function getStyles($footer = false) {
		if(!$footer) {
			return $this->styles;
		} else {
			return $this->footer_styles;
		}
	}	
	
	/**
	 * Add scripts to target array wich looped in same template and include it 
	 * @param string $script
	 * @param boolean $footer
	 */
	public function addScript($script, $footer = false) {
	    if($footer) {
	        $this->footer_scripts[md5($script)] = $script;
	    } else {
	        $this->scripts[md5($script)] = $script;
	    }			
	}
	
	public function getScripts($footer = false) {
	    if($footer) {
	        return $this->footer_scripts;
	    } else {
		  return $this->scripts;	        
	    }
	}
	
	/*
	 * Add type Script files
	 * */
	public function addTs($file) {
		$this->ts_requeire = true;
	}
	
	public function getTs() {
		return $this->ts_scripts;
	}
	
	/*
	 * Check if TypeScript Core require
	 * */
	public function isTsRequire() {
		return $this->ts_requeire;
	}
}
?>