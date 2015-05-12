<?php
class Response {
	private $headers = array(); 
	private $level = 0;
	private $output;
	
	public function addHeader($header) {
		$this->headers[] = $header;
	}

	public function redirect($url) {
		header('Location: ' . html_entity_decode($url));
		exit;
	}
	
	public function setCompression($level) {
		$this->level = $level;
	}
		
	public function setOutput($output) {
	    if(defined('PAGE_CACHING') && PAGE_CACHING) {
	        if(PAGE_CACHE_FILE) {
	    	
	            global $caching_restricted_routes;
	            global $request;
	            $current_route = empty($request->get['route']) ? 'common/home' : $request->get['route'];
	    
	            $route_ok = (!in_array($current_route, $caching_restricted_routes));

	            foreach($this->headers as $header) {
	                if(strstr($header, '/1.1 404')) {
	                    $route_ok = false;
	                    break;
	                }
	            }
	            if (preg_match('/<html\b/i', $output) && $route_ok) {
	                global $timer;
	                if($timer) {
	                    $output .= '
<!-- WITHOUT CACHE: ' . $timer->stop() . ' -->';
	                }
	                $write = utf8_encode($output);
	                if(PAGE_ZLIB) {
	                    $gz = gzopen(PAGE_CACHE_FILE,'w9');
                        gzwrite($gz, $write);
	                    gzclose($gz);
	                } else {
	                    file_put_contents(PAGE_CACHE_FILE, $write);
	                }
	            }
	        }
            // Что тут блять происходит, какого х...
	    } else {
            if(defined('IS_ADMIN_FOLDER')){
                echo $output;
                return;
            }
        }
		$this->output = $output;
	}

	private function compress($data, $level = 0) {
		if (isset($_SERVER['HTTP_ACCEPT_ENCODING']) && (strpos($_SERVER['HTTP_ACCEPT_ENCODING'], 'gzip') !== false)) {
			$encoding = 'gzip';
		} 

		if (isset($_SERVER['HTTP_ACCEPT_ENCODING']) && (strpos($_SERVER['HTTP_ACCEPT_ENCODING'], 'x-gzip') !== false)) {
			$encoding = 'x-gzip';
		}

		if (!isset($encoding)) {
			return $data;
		}

		if (!extension_loaded('zlib') || ini_get('zlib.output_compression')) {
			return $data;
		}

		if (headers_sent()) {
			return $data;
		}

		if (connection_status()) { 
			return $data;
		}
		
		$this->addHeader('Content-Encoding: ' . $encoding);

		return gzencode($data, (int)$level);
	}

	public function output() {
		if ($this->output) {
			if ($this->level) {
				$output = $this->compress($this->output, $this->level);
			} else {
				$output = $this->output;
			}	
				
			if (!headers_sent()) {
				foreach ($this->headers as $header) {
					header($header, true);
				}
			}
			
			echo $output;
		}
	}
}
?>