<?php
class Pagination {
	public $total = 0;
	public $page = 1;
	public $limit = 20;
	public $num_links = 10;
	public $url = '';
	public $text = 'Showing {start} to {end} of {total} ({pages} Pages)';
	public $text_first = '|&lt;';
	public $text_last = '&gt;|';
	public $text_next = '&gt;';
	public $text_prev = '&lt;';
	public $style_links = 'links';
	public $style_results = 'results';

	public function render() {
		$total = $this->total;
		
		if ($this->page < 1) {
			$page = 1;
		} else {
			$page = $this->page;
		}
		
		if (!(int)$this->limit) {
			$limit = 10;
		} else {
			$limit = $this->limit;
		}
		
		$num_links = $this->num_links;
		$num_pages = ceil($total / $limit);
		
		$output = '';
		
		if ($page > 1) {
			$output .= ' <a href="' . str_replace('{page}', 1, $this->url) . '">' . $this->text_first . '</a> <a href="' . str_replace('{page}', $page - 1, $this->url) . '" rel="prev">' . $this->text_prev . '</a> ';
		}

		if ($num_pages > 1) {
			if ($num_pages <= $num_links) {
				$start = 1;
				$end = $num_pages;
			} else {
				$start = $page - floor($num_links / 2);
				$end = $page + floor($num_links / 2);
			
				if ($start < 1) {
					$end += abs($start) + 1;
					$start = 1;
				}
						
				if ($end > $num_pages) {
					$start -= ($end - $num_pages);
					$end = $num_pages;
				}
			}

			if ($start > 1) {
				$output .= ' .... ';
			}

			for ($i = $start; $i <= $end; $i++) {
				if ($page == $i) {
					$output .= ' <b>' . $i . '</b> ';
				} else {
					$output .= ' <a href="' . str_replace('{page}', $i, $this->url) . '">' . $i . '</a> ';
				}	
			}
							
			if ($end < $num_pages) {
				$output .= ' .... ';
			}
		}
		
		if ($page < $num_pages) {
			$output .= ' <a href="' . str_replace('{page}', $page + 1, $this->url) . '" rel="next">' . $this->text_next . '</a> <a href="' . str_replace('{page}', $num_pages, $this->url) . '">' . $this->text_last . '</a> ';
		}
		
		$find = array(
			'{start}',
			'{end}',
			'{total}',
			'{pages}'
		);
		
		$replace = array(
			($total) ? (($page - 1) * $limit) + 1 : 0,
			((($page - 1) * $limit) > ($total - $limit)) ? $total : ((($page - 1) * $limit) + $limit),
			$total, 
			$num_pages
		);
		
		$str = ($output ? '<div class="' . $this->style_links . '">' . $output . '</div>' : '');
		
		if($output) {
		    
    		$str1 = str_replace('<div class="links">', '<ul class="pagination">', $str);
    		$str2 = str_replace('</div>', '</ul>', $str1);
    		$str3 = str_replace('<a', '<li><a', $str2);
    		$str4 = str_replace('</a>', '</a></li>', $str3);
    		$str5 = str_replace('<b>', '<li class="active"><a>', $str4);
    		$str6 = str_replace('</b>', '<span class="sr-only">(current)</span></a></li>', $str5);
    		$str7 = str_replace('&gt;|', '<i class="fa fa-angle-double-right"></i>', $str6);
    		$str8 = str_replace('&gt;', '<i class="fa fa-angle-right"></i>', $str7);
    		$str9 = str_replace('|&lt;', '<i class="fa fa-angle-double-left"></i>', $str8);
    		$str10 = str_replace('&lt;', '<i class="fa fa-angle-left"></i>', $str9);
    		$str11 = str_replace('....', '<li class="disabled"><span>....</span></li>', $str10);
    		
    		return $str11 . '<div class="' . $this->style_results . '">' . str_replace($find, $replace, $this->text) . '</div>';
    		
		} else {
		    return $str;
		    
		}
		
	}
	
	public function getLast() {
		$total = $this->total;
		$end = 1;
	
		if ($this->page < 1) {
			$page = 1;
		} else {
			$page = $this->page;
		}
	
		if (!(int)$this->limit) {
			$limit = 10;
		} else {
			$limit = $this->limit;
		}
	
		$num_links = $this->num_links;
		$num_pages = ceil($total / $limit);
	
		if ($num_pages > 1) {
			if ($num_pages <= $num_links) {
				$start = 1;
				$end = $num_pages;
			} else {
				$start = $page - floor($num_links / 2);
				$end = $page + floor($num_links / 2);
					
				if ($start < 1) {
					$end += abs($start) + 1;
					$start = 1;
				}
	
				if ($end > $num_pages) {
					$start -= ($end - $num_pages);
					$end = $num_pages;
				}
			}
		}
	
		return $end;
	}
}
?>